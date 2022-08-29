import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';
import 'package:under_control_v2/features/core/presentation/widgets/overlay_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../user_profile/presentation/pages/user_details_page.dart';
import '../../utils/responsive_size.dart';
import '../../utils/size_config.dart';
import 'cached_user_avatar.dart';
import 'url_launcher_helpers.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({
    Key? key,
    required this.group,
    required this.user,
    required this.onDismiss,
  }) : super(key: key);

  final Group group;
  final UserProfile user;
  final VoidCallback onDismiss;

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> with ResponsiveSize {
  bool _hasCallSupport = false;
  late UserProfile currentUser;
  late UserProfile selectedUser;

  void toggleGroupAdmin(bool value) {
    if (value) {
      context.read<UserManagementBloc>().add(
            AssignGroupAdminEvent(
              groupId: widget.group.id,
              userId: selectedUser.id,
              companyId: selectedUser.companyId,
            ),
          );
    } else {
      context.read<UserManagementBloc>().add(
            UnassignGroupAdminEvent(
              groupId: widget.group.id,
              userId: selectedUser.id,
              companyId: selectedUser.companyId,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  void didChangeDependencies() {
    final userState = (context.read<UserProfileBloc>().state as Approved);
    currentUser = userState.userProfile;
    final companyState =
        (context.watch<CompanyProfileBloc>().state as CompanyProfileLoaded);
    final index = companyState.companyUsers.allUsers
        .indexWhere((element) => element.id == widget.user.id);
    selectedUser = companyState.companyUsers.allUsers[index];
    super.didChangeDependencies();
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
                  child: CachedUserAvatar(
                    size: responsiveSizePct(small: 60),
                    imageUrl: selectedUser.avatarUrl,
                  ),
                ),

                // first name
                Text(
                  selectedUser.firstName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                // last name
                Text(
                  selectedUser.lastName,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                // toggle group administrator
                if (currentUser.administrator && !selectedUser.administrator)
                  Column(
                    children: [
                      const Divider(thickness: 1.5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gpp_good,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .user_details_group_admin,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Switch(
                              value: widget.group.groupAdministrators
                                  .contains(selectedUser.id),
                              onChanged: toggleGroupAdmin,
                              activeColor: Theme.of(context).primaryColor,
                              activeTrackColor:
                                  Theme.of(context).primaryColor.withAlpha(50),
                            )
                          ],
                        ),
                      ),
                      const Divider(thickness: 1.5),
                    ],
                  ),
                const SizedBox(height: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_hasCallSupport)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // call
                          OverlayIconButton(
                            onPressed: () =>
                                makePhoneCall(selectedUser.phoneNumber),
                            icon: Icons.call,
                            title: AppLocalizations.of(context)!.call,
                          ),
                          // send sms
                          OverlayIconButton(
                            onPressed: () => sendSms(selectedUser.phoneNumber),
                            icon: Icons.message,
                            title: AppLocalizations.of(context)!.send_sms,
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // send email
                        OverlayIconButton(
                          onPressed: () => mailTo(selectedUser.email),
                          icon: Icons.email,
                          title: AppLocalizations.of(context)!.send_email,
                        ),
                        // go to profile page
                        OverlayIconButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            UserDetailsPage.routeName,
                            (route) => route.isFirst,
                            arguments: selectedUser,
                          ),
                          icon: Icons.person,
                          title:
                              AppLocalizations.of(context)!.user_show_profile,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
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
