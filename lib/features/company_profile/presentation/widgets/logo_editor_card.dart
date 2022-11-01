import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/presentation/widgets/glass_layer.dart';
import '../../../core/presentation/widgets/overlay_icon_button.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';
import '../../domain/entities/company.dart';
import '../blocs/company_management/company_management_bloc.dart';

class LogoEditorCard extends StatefulWidget {
  const LogoEditorCard({
    Key? key,
    required this.company,
    required this.onDismiss,
  }) : super(key: key);

  final Company company;
  final VoidCallback onDismiss;

  @override
  State<LogoEditorCard> createState() => _LogoEditorCardState();
}

class _LogoEditorCardState extends State<LogoEditorCard> with ResponsiveSize {
  File? _logo;

  void _setAvatar(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        setState(() {
          _logo = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!
                  .user_profile_add_user_image_pisker_error,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GlassLayer(
      onDismiss: widget.onDismiss,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // avatar
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  // indexed stack
                  child: IndexedStack(
                    index: _logo == null ? 0 : 1,
                    children: [
                      // original logo
                      SizedBox(
                        height: responsiveSizePct(small: 90),
                        width: responsiveSizePct(small: 90),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.company.logo,
                        ),
                      ),

                      // updated logo
                      if (_logo != null)
                        SizedBox(
                          height: responsiveSizePct(small: 90),
                          width: responsiveSizePct(small: 90),
                          child: Image.file(
                            fit: BoxFit.cover,
                            _logo!,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // camera button
                    OverlayIconButton(
                      onPressed: () => _setAvatar(ImageSource.camera),
                      icon: Icons.camera,
                      title: AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_take_photo_btn,
                    ),
                    // gallery button
                    OverlayIconButton(
                      onPressed: () => _setAvatar(ImageSource.gallery),
                      icon: Icons.photo_size_select_actual_rounded,
                      title: AppLocalizations.of(context)!
                          .user_profile_add_user_personal_data_gallery,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () => widget.onDismiss(),
                    ),
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_save,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        context.read<CompanyManagementBloc>().add(
                              AddCompanyLogoEvent(
                                company: widget.company,
                                logo: _logo,
                              ),
                            );
                        widget.onDismiss();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
