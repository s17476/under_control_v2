import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/company_profile/presentation/widgets/user_management_dialogs.dart';
import 'package:under_control_v2/features/core/presentation/widgets/cached_user_avatar.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_row.dart';
import 'package:under_control_v2/features/core/presentation/widgets/loading_widget.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/presentation/widgets/group_management/group_tile.dart';

import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../../core/utils/choice.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../domain/entities/user_profile.dart';
import '../blocs/user_profile/user_profile_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/users/user-details';

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> with ResponsiveSize {
  UserProfile? user;
  late UserProfile currentUser;
  late List<Choice> choices;

  @override
  void didChangeDependencies() {
    // gets selected user
    final userId =
        (ModalRoute.of(context)?.settings.arguments as UserProfile).id;
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      final index = companyState.companyUsers.allUsers
          .indexWhere((element) => element.id == userId);
      if (index >= 0) {
        user = companyState.companyUsers.allUsers[index];
      }
    }
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      currentUser = currentState.userProfile;
    }
    // popup menu items
    choices = [
      // edit user
      Choice(
        title: AppLocalizations.of(context)!.suspend,
        icon: Icons.edit,
        onTap: () => print('EDIT'),
      ),
      // suspend user
      if (user!.id != currentUser.id && currentUser.administrator)
        Choice(
          title: AppLocalizations.of(context)!.suspend,
          icon: Icons.person_off,
          onTap: () => showUserSuspendDialog(context: context, user: user!),
        ),
      // make admin
      if (user!.id != currentUser.id &&
          !user!.administrator &&
          currentUser.administrator)
        Choice(
          title: AppLocalizations.of(context)!.user_make_admin,
          icon: Icons.gpp_good,
          onTap: () => showMakeAdminDialog(context: context, user: user!),
        ),
      // revoke admin
      if (user!.id != currentUser.id &&
          user!.administrator &&
          currentUser.administrator)
        Choice(
          title: AppLocalizations.of(context)!.user_unmake_admin,
          icon: Icons.gpp_bad,
          onTap: () => showUnmakeAdminDialog(context: context, user: user!),
        ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
        title: Text(AppLocalizations.of(context)!.user_details_title),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        actions: [
          // suspend button
          if (user != null)
            PopupMenuButton<Choice>(
              onSelected: (Choice choice) => choice.onTap(),
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
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
      body: user == null
          ? const LoadingWidget()
          : SizedBox(
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
                            imageUrl: user!.avatarUrl,
                          ),
                          Text(
                            user!.firstName,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.white,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            user!.lastName,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
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
                            title:
                                AppLocalizations.of(context)!.user_details_data,
                            titleFontSize: 16,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // phone number
                          InkWell(
                            onTap: () => makePhoneCall(user!.phoneNumber),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                  Text(user!.phoneNumber),
                                ],
                              ),
                            ),
                          ),
                          // sms
                          InkWell(
                            onTap: () => sendSms(user!.phoneNumber),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                      AppLocalizations.of(context)!
                                          .user_details_sms,
                                    ),
                                  ),
                                  Text(user!.phoneNumber),
                                ],
                              ),
                            ),
                          ),
                          // email
                          InkWell(
                            onTap: () => mailTo(user!.email),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                                    user!.email,
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
                                  user!.administrator
                                      ? Icons.gpp_good
                                      : Icons.gpp_bad,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .user_details_admin,
                                  ),
                                ),
                                Text(
                                  user!.administrator
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
                            title: AppLocalizations.of(context)!
                                .drawer_item_groups,
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
                                  if (user!.userGroups.contains(group.id)) {
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
