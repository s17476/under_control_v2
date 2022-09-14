import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';
import '../blocs/user_management/user_management_bloc.dart';
import '../blocs/user_profile/user_profile_bloc.dart';

class NotApprovedPage extends StatelessWidget with ResponsiveSize {
  const NotApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();
    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.black,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: BlocListener<UserManagementBloc, UserManagementState>(
        listener: (context, state) {
          if (state is UserManagementSuccessful && state.message.isNotEmpty) {
            showSnackBar(context: context, message: state.message);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // image
                Container(
                  height: responsiveSizeVerticalPct(small: 40),
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(
                    'assets/validation.png',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                // message and buttons
                BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                  builder: (context, state) {
                    // check if there are other users
                    bool isAdministrator = false;
                    if (state is CompanyProfileLoaded &&
                        state.companyUsers.allUsers.isEmpty) {
                      isAdministrator = true;
                    }
                    return SizedBox(
                      height: responsiveSizeVerticalPct(small: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.well_done,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          if (!isAdministrator)
                            Text(
                              AppLocalizations.of(context)!.approve_page_text,
                              textAlign: TextAlign.justify,
                            ),
                          if (isAdministrator)
                            Text(
                              AppLocalizations.of(context)!
                                  .approve_page_admin_text,
                              textAlign: TextAlign.justify,
                            ),
                          if (!isAdministrator)
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<UserProfileBloc>().add(
                                        GetUserByIdEvent(
                                          userId: (context
                                                  .read<UserProfileBloc>()
                                                  .state as NotApproved)
                                              .userProfile
                                              .id,
                                        ),
                                      ),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .approve_page_change_button_refresh,
                              ),
                            ),
                          if (isAdministrator)
                            ElevatedButton(
                              onPressed: () {
                                context.read<UserManagementBloc>().add(
                                      ApproveUserAndMakeAdminEvent(
                                        userId: (context
                                                .read<UserProfileBloc>()
                                                .state as NotApproved)
                                            .userProfile
                                            .id,
                                      ),
                                    );
                                context.read<UserProfileBloc>().add(
                                      GetUserByIdEvent(
                                        userId: (context
                                                .read<UserProfileBloc>()
                                                .state as NotApproved)
                                            .userProfile
                                            .id,
                                      ),
                                    );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.continue_btn,
                              ),
                            ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actionsAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .assign_company_list_confirm_dialog_title,
                                  ),
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .approve_page_change_dialog_text,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)!.cancel,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .color,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        AppLocalizations.of(context)!.change,
                                      ),
                                      onPressed: () {
                                        context.read<UserProfileBloc>().add(
                                              ResetCompanyEvent(
                                                userProfile: (context
                                                        .read<UserProfileBloc>()
                                                        .state as NotApproved)
                                                    .userProfile,
                                              ),
                                            );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .approve_page_change_button,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
