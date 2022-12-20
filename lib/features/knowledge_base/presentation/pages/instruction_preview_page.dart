import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/get_cached_firebase_storage_file.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';

import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/presentation/widgets/user_info_card.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/instruction.dart';
import '../../utils/show_instruction_delete_dialog.dart';
import '../blocs/instruction/instruction_bloc.dart';
import '../blocs/instruction_management/instruction_management_bloc.dart';
import '../widgets/instruction_preview/instruction_details_card.dart';
import '../widgets/instruction_preview/step_details_card.dart';
import 'add_instruction_page.dart';

class InstructionPreviewPage extends StatefulWidget {
  const InstructionPreviewPage({Key? key}) : super(key: key);

  static const routeName = '/knowledge/preview';

  @override
  State<InstructionPreviewPage> createState() => _InstructionPreviewPageState();
}

class _InstructionPreviewPageState extends State<InstructionPreviewPage> {
  final _pageController = PageController();
  Instruction? _instruction;
  String _appBarTitle = '';
  List<Widget> _pages = [];
  List<Choice> _choices = [];
  UserProfile? _userProfile;
  bool _isUserInfoCardVisible = false;

  void _showUserInfoCard(UserProfile userProfile) {
    setState(() {
      _userProfile = userProfile;
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = false;
      _userProfile = null;
    });
  }

  @override
  void didChangeDependencies() {
    // get instruction
    final instructionId =
        (ModalRoute.of(context)?.settings.arguments as Instruction).id;
    final instructionsState = context.watch<InstructionBloc>().state;
    if (instructionsState is InstructionLoadedState) {
      final index = instructionsState.allInstructions.allInstructions
          .indexWhere((inst) => inst.id == instructionId);
      if (index >= 0) {
        setState(() {
          _instruction =
              instructionsState.allInstructions.allInstructions[index];
        });
        // precache images
        final imagesToPrecache = _instruction!.steps
            .where((stp) => stp.contentType == ContentType.image)
            .map((stp) => stp.contentUrl);
        for (var imageUrl in imagesToPrecache) {
          if (imageUrl != null) {
            precacheImage(CachedNetworkImageProvider(imageUrl), context);
          }
        }
        // precache video
        final videosToPrecache = _instruction!.steps
            .where((stp) => stp.contentType == ContentType.video)
            .map((stp) => stp.contentUrl);
        for (var videoUrl in videosToPrecache) {
          if (videoUrl != null) {
            getCachedFirebaseStorageFile(videoUrl);
          }
        }
        // popup menu items
        _choices = [
          // edit item
          if (getUserPermission(
            context: context,
            featureType: FeatureType.knowledgeBase,
            permissionType: PermissionType.edit,
          ))
            Choice(
              title: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              onTap: () => Navigator.pushNamed(
                context,
                AddInstructionPage.routeName,
                arguments: _instruction,
              ),
            ),
          if (getUserPermission(
            context: context,
            featureType: FeatureType.knowledgeBase,
            permissionType: PermissionType.delete,
          ))
            Choice(
              title: AppLocalizations.of(context)!.delete,
              icon: Icons.delete,
              onTap: () async {
                final result = await showInstructionDeleteDialog(
                    context: context, instruction: _instruction!);
                if (result != null && result && mounted) {
                  Navigator.pop(context);
                }
              },
            ),
        ];
        if (!_pageController.hasClients) {
          _appBarTitle = AppLocalizations.of(context)!.instruction_details;
        }
        _pageController.addListener(
          () {
            if ((_pageController.page! + 0.5).toInt() == 0) {
              setState(() {
                _appBarTitle =
                    AppLocalizations.of(context)!.instruction_details;
              });
            } else {
              setState(() {
                _appBarTitle =
                    '${AppLocalizations.of(context)!.instruction_step} ${(_pageController.page! + 0.5).toInt()}';
              });
            }
          },
        );
        _pages = [
          InstructionDetailsCard(
            instruction: _instruction!,
            showUserInfoCard: _showUserInfoCard,
          ),
          for (var step in _instruction!.steps)
            KeepAlivePage(
              child: StepDetailsCard(
                step: step,
              ),
            ),
        ];
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isUserInfoCardVisible) {
          _hideUserInfoCard();
          return false;
        }
        return true;
      },
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
          // backgroundColor: Colors.grey,
          appBar: orientation == Orientation.landscape
              ? null
              : AppBar(
                  title: Text(_appBarTitle),
                  centerTitle: true,
                  leading: Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const AppBarAnimatedIcon(isBackIcon: true),
                      );
                    },
                  ),
                  actions: [
                    // popup menu
                    if (getUserPermission(
                      context: context,
                      featureType: FeatureType.knowledgeBase,
                      permissionType: PermissionType.edit,
                    ))
                      PopupMenuButton<Choice>(
                        onSelected: (Choice choice) {
                          _hideUserInfoCard();
                          choice.onTap();
                        },
                        itemBuilder: (BuildContext context) {
                          return _choices.map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(choice.icon),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    choice.title,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                      ),
                  ],
                ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                controller: _pageController,
                children: _pages,
              ),
              // bottom navigation
              if (orientation == Orientation.portrait)
                CreatorBottomNavigation(
                  firstPageBackwardButtonFunction: () => Navigator.pop(context),
                  firstPageBackwardButtonIconData: Icons.arrow_back_ios_new,
                  firstPageBackwardButtonLabel: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  lastPageForwardButtonFunction: () => Navigator.pop(context),
                  lastPageForwardButtonIconData: Icons.done,
                  lastPageForwardButtonLabel:
                      AppLocalizations.of(context)!.done,
                  pages: _pages,
                  pageController: _pageController,
                ),
              // user info card
              if (_isUserInfoCardVisible)
                UserInfoCard(
                  onDismiss: _hideUserInfoCard,
                  user: _userProfile!,
                ),
              //shows loading indicator while updating instruction
              BlocBuilder<InstructionManagementBloc,
                  InstructionManagementState>(
                builder: (context, state) {
                  if (state is InstructionManagementLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
