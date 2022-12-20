import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../utils/show_add_instruction_category_modal_bottom_sheet.dart';
import '../blocs/instruction_category/instruction_category_bloc.dart';
import '../widgets/instruction_category_management_bloc_listener.dart';
import '../widgets/instruction_category_tile.dart';

class InstructionCategoryManagementPage extends StatefulWidget {
  const InstructionCategoryManagementPage({Key? key}) : super(key: key);

  static const routeName = '/knowledge-base/categories';

  @override
  State<InstructionCategoryManagementPage> createState() =>
      _InstructionCategoryManagementPageState();
}

class _InstructionCategoryManagementPageState
    extends State<InstructionCategoryManagementPage> {
  bool _isAdministrator = false;
  late UserProfile _currentUser;

  @override
  void didChangeDependencies() {
    _currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    _isAdministrator = _currentUser.administrator;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.item_category_title),
        centerTitle: true,
      ),
      body: InstructionCategoryManagementBlocListener(
        child: BlocBuilder<InstructionCategoryBloc, InstructionCategoryState>(
          builder: (context, state) {
            if (state is InstructionCategoryLoadedState) {
              return ListView.builder(
                itemCount: state.allInstructionsCategories
                        .allInstructionsCategories.length +
                    1,
                itemBuilder: (context, index) {
                  if (index ==
                      state.allInstructionsCategories.allInstructionsCategories
                          .length) {
                    return const SizedBox(
                      height: 80,
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InstructionCategoryTile(
                          isAdministrator: _isAdministrator,
                          instructionCategory: state.allInstructionsCategories
                              .allInstructionsCategories[index],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
      floatingActionButton: getUserPremission(
        context: context,
        featureType: FeatureType.inventory,
        premissionType: PermissionType.create,
      )
          ? context.watch<InstructionCategoryBloc>().state
                  is InstructionCategoryLoadedState
              ? FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    showAddInstructionCategoryModalBottomSheet(
                        context: context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey.shade200,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.item_category_add_new,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                    ),
                  ),
                )
              // bloc state is not loaded
              : null
          // not an administrator
          : null,
    );
  }
}
