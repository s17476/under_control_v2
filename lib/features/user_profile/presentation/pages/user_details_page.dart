import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/cached_user_avatar.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_row.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/presentation/widgets/group_management/group_tile.dart';

import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../domain/entities/user_profile.dart';

class UserDetailsPage extends StatelessWidget with ResponsiveSize {
  const UserDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/users/user-details';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final user = ModalRoute.of(context)?.settings.arguments as UserProfile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
        title: Text(AppLocalizations.of(context)!.user_details_title),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        // actions: [
        //   if(user.administrator || user)
        // ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // avatar and name
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: const Alignment(0, 1),
                    colors: [
                      Theme.of(context).primaryColor.withAlpha(50),
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(50),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    CachedUserAvatar(
                      size: responsiveSizePct(small: 70),
                      imageUrl: user.avatarUrl,
                    ),
                    Text(
                      user.firstName,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.lastName,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // user data
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    // title
                    IconTitleRow(
                      icon: Icons.person,
                      iconColor: Colors.grey.shade300,
                      iconBackground: Colors.black,
                      title: AppLocalizations.of(context)!.user_details_data,
                      titleFontSize: 16,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // phone number
                    InkWell(
                      onTap: () => makePhoneCall(user.phoneNumber),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .add_company_intro_card_phone_number,
                              ),
                            ),
                            Text(user.phoneNumber),
                          ],
                        ),
                      ),
                    ),
                    // sms
                    InkWell(
                      onTap: () => sendSms(user.phoneNumber),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.user_details_sms,
                              ),
                            ),
                            Text(user.phoneNumber),
                          ],
                        ),
                      ),
                    ),
                    // email
                    InkWell(
                      onTap: () => mailTo(user.email),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .add_company_intro_card_email,
                              ),
                            ),
                            Text(
                              user.email,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
                thickness: 1.5,
              ),

              // user premissions
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    // title
                    IconTitleRow(
                      icon: Icons.error,
                      iconColor: Colors.grey.shade300,
                      iconBackground: Colors.black,
                      title: AppLocalizations.of(context)!
                          .user_details_premissions,
                      titleFontSize: 16,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // administrator
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.gpp_good,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.user_details_admin,
                            ),
                          ),
                          Text(
                            user.administrator
                                ? AppLocalizations.of(context)!.yes
                                : AppLocalizations.of(context)!.no,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 8,
                endIndent: 8,
                thickness: 1.5,
              ),

              // user groups
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  children: [
                    // title
                    IconTitleRow(
                      icon: Icons.group,
                      iconColor: Colors.grey.shade300,
                      iconBackground: Colors.black,
                      title: AppLocalizations.of(context)!.drawer_item_groups,
                      titleFontSize: 16,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // groups
                    BlocBuilder<GroupBloc, GroupState>(
                      builder: (context, state) {
                        if (state is GroupLoadedState) {
                          List<Group> userGroups = [];
                          for (var group in state.allGroups.allGroups) {
                            if (user.userGroups.contains(group.id)) {
                              userGroups.add(group);
                            }
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userGroups.length,
                            itemBuilder: (context, index) =>
                                GroupTile(group: userGroups[index]),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
