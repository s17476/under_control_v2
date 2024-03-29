import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'custom_multi_bloc_provider.dart';
import 'features/assets/presentation/pages/add_asset_page.dart';
import 'features/assets/presentation/pages/asset_category_management_page.dart';
import 'features/assets/presentation/pages/asset_details_page.dart';
import 'features/assets/presentation/pages/task_archive_for_asset_page.dart';
import 'features/assets/presentation/widgets/asset_details/asset_actions_list_page.dart';
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/email_confirmation_page.dart';
import 'features/checklists/presentation/pages/add_checklist_page.dart';
import 'features/checklists/presentation/pages/checklist_details_page.dart';
import 'features/checklists/presentation/pages/checklist_management_page.dart';
import 'features/company_profile/presentation/pages/add_company_page.dart';
import 'features/company_profile/presentation/pages/assign_company_page.dart';
import 'features/company_profile/presentation/pages/company_details_page.dart';
import 'features/core/presentation/pages/home_page.dart';
import 'features/core/presentation/pages/loading_page.dart';
import 'features/core/presentation/pages/passive_home_page.dart';
import 'features/core/presentation/pages/qr_scanner.dart';
import 'features/core/themes/themes.dart';
import 'features/core/utils/custom_page_transition.dart';
import 'features/core/utils/error_message_handler.dart';
import 'features/core/utils/material_color_generator.dart';
import 'features/dashboard/presentation/pages/all_actions_list_page.dart';
import 'features/dashboard/presentation/pages/all_asset_actions_page.dart';
import 'features/dashboard/presentation/pages/all_assets_without_inspection_list_page.dart';
import 'features/dashboard/presentation/pages/all_low_level_items_page.dart';
import 'features/groups/presentation/pages/add_group_page.dart';
import 'features/groups/presentation/pages/group_details.dart';
import 'features/groups/presentation/pages/group_management_page.dart';
import 'features/inventory/presentation/pages/actions_list_page.dart';
import 'features/inventory/presentation/pages/add_item_page.dart';
import 'features/inventory/presentation/pages/add_to_item_page.dart';
import 'features/inventory/presentation/pages/item_category_management_page.dart';
import 'features/inventory/presentation/pages/item_details_page.dart';
import 'features/inventory/presentation/pages/move_inside_item_page.dart';
import 'features/inventory/presentation/pages/subtract_from_item_page.dart';
import 'features/knowledge_base/presentation/pages/add_instruction_page.dart';
import 'features/knowledge_base/presentation/pages/instruction_category_management_page.dart';
import 'features/knowledge_base/presentation/pages/instruction_preview_page.dart';
import 'features/locations/presentation/pages/location_management_page.dart';
import 'features/notifications/presentation/pages/notifications_page.dart';
import 'features/settings/presentation/blocs/language/language_cubit.dart';
import 'features/settings/presentation/pages/language_settings_page.dart';
import 'features/settings/presentation/pages/notification_settings_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/tasks/presentation/pages/add_task_page.dart';
import 'features/tasks/presentation/pages/add_task_template_page.dart';
import 'features/tasks/presentation/pages/add_work_request_page.dart';
import 'features/tasks/presentation/pages/register_task_action_page.dart';
import 'features/tasks/presentation/pages/select_new_assets_data_page.dart';
import 'features/tasks/presentation/pages/subtract_item_from_location_page.dart';
import 'features/tasks/presentation/pages/task_action_details_page.dart';
import 'features/tasks/presentation/pages/task_archive_page.dart';
import 'features/tasks/presentation/pages/task_details_page.dart';
import 'features/tasks/presentation/pages/task_template_details_page.dart';
import 'features/tasks/presentation/pages/templates_management_page.dart';
import 'features/tasks/presentation/pages/work_request_archive_page.dart';
import 'features/tasks/presentation/pages/work_request_details_page.dart';
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'features/user_profile/presentation/pages/add_user_profile_page.dart';
import 'features/user_profile/presentation/pages/new_users_list_page.dart';
import 'features/user_profile/presentation/pages/not_approved_page.dart';
import 'features/user_profile/presentation/pages/suspended_users_list_page.dart';
import 'features/user_profile/presentation/pages/user_details_page.dart';
import 'features/user_profile/presentation/pages/users_list_page.dart';
import 'firebase_options.dart';
import 'injection.dart';
import 'features/notifications/utils/notifications_helpers.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  await configureInjection();
  runApp(const App());
}

class App extends StatelessWidget
    with CustomPageTransition, MaterialColorGenerator {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiBlocProvider(
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return GestureDetector(
            onTap: () {
              final focusScope = FocusScope.of(context);
              final focusNode = focusScope.focusedChild;
              if (!focusScope.hasPrimaryFocus && focusNode != null) {
                focusNode.unfocus();
              }
            },
            child: MaterialApp(
              builder: (context, child) => ResponsiveWrapper.builder(
                child,
                defaultScale: true,
                // maxWidth: 1200,
                // minWidth: 480,

                breakpoints: const [
                  ResponsiveBreakpoint.resize(350, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(600, name: TABLET),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
              ),
              debugShowCheckedModeBanner: false,
              title: 'UnderControl',
              locale: locale,
              theme: Themes().darkTheme(),
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  // user authenticated
                  if (state is Authenticated) {
                    return BlocConsumer<UserProfileBloc, UserProfileState>(
                      listener: (context, state) {
                        showValidationSnackBar(state, context);
                      },
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case Approved:
                            if ((state as Approved).userProfile.isActive) {
                              return const HomePage();
                            }
                            return const PassiveHomePage();
                          case NoUserProfileError:
                            return const AddUserProfilePage();
                          case NoCompanyState:
                            return const AssignCompanyPage();
                          case NotApproved:
                            return const NotApprovedPage();
                          default:
                            return const LoadingPage();
                        }
                      },
                    );
                    // awaiting email verification
                  } else if (state is AwaitingVerification) {
                    return const EmailConfirmationPage();
                    // user not authenticated
                  } else {
                    return const AuthenticationPage();
                  }
                },
              ),
              // pages
              routes: {
                HomePage.routeName: (context) => const HomePage(),
                PassiveHomePage.routeName: (context) => const PassiveHomePage(),
                AuthenticationPage.routeName: (context) =>
                    const AuthenticationPage(),
                AddCompanyPage.routeName: (context) => const AddCompanyPage(),
                LocationManagementPage.routeName: (context) =>
                    const LocationManagementPage(),
                GroupManagementPage.routeName: (context) =>
                    const GroupManagementPage(),
                AddGroupPage.routeName: (context) => const AddGroupPage(),
                GroupDetailsPage.routeName: (context) =>
                    const GroupDetailsPage(),
                UserDetailsPage.routeName: (context) => const UserDetailsPage(),
                UsersListPage.routeName: (context) => const UsersListPage(),
                NewUsersListPage.routeName: (context) =>
                    const NewUsersListPage(),
                SuspendedUsersListPage.routeName: (context) =>
                    const SuspendedUsersListPage(),
                CompanyDetailsPage.routeName: (context) =>
                    const CompanyDetailsPage(),
                ChecklistManagementPage.routeName: (context) =>
                    const ChecklistManagementPage(),
                AddChecklistPage.routeName: (context) =>
                    const AddChecklistPage(),
                ChecklistDetailsPage.routeName: (context) =>
                    const ChecklistDetailsPage(),
                ItemCategoryManagementPage.routeName: (context) =>
                    const ItemCategoryManagementPage(),
                AddItemPage.routeName: (context) => const AddItemPage(),
                AddToItemPage.routeName: (context) => const AddToItemPage(),
                SubtractFromItemPage.routeName: (context) =>
                    const SubtractFromItemPage(),
                MoveInsideItemPage.routeName: (context) =>
                    const MoveInsideItemPage(),
                ItemDetailsPage.routeName: (context) => const ItemDetailsPage(),
                ActionsListPage.routeName: (context) => const ActionsListPage(),
                AllActionsListPage.routeName: (context) =>
                    const AllActionsListPage(),
                QrScanner.routeName: (context) => const QrScanner(),
                InstructionCategoryManagementPage.routeName: (context) =>
                    const InstructionCategoryManagementPage(),
                AddInstructionPage.routeName: (context) =>
                    const AddInstructionPage(),
                InstructionPreviewPage.routeName: (context) =>
                    const InstructionPreviewPage(),
                AssetCategoryManagementPage.routeName: (context) =>
                    const AssetCategoryManagementPage(),
                AllLowLevelItemsPage.routeName: (context) =>
                    const AllLowLevelItemsPage(),
                AddAssetPage.routeName: (context) => const AddAssetPage(),
                AssetDetailsPage.routeName: (context) =>
                    const AssetDetailsPage(),
                AssetActionsListPage.routeName: (context) =>
                    const AssetActionsListPage(),
                AllAssetActionsListPage.routeName: (context) =>
                    const AllAssetActionsListPage(),
                AllAssetsWithoutInspectionListPage.routeName: (context) =>
                    const AllAssetsWithoutInspectionListPage(),
                AddWorkRequestPage.routeName: (context) =>
                    const AddWorkRequestPage(),
                WorkRequestDetailsPage.routeName: (context) =>
                    const WorkRequestDetailsPage(),
                WorkRequestArchivePage.routeName: (context) =>
                    const WorkRequestArchivePage(),
                AddTaskPage.routeName: (context) => const AddTaskPage(),
                TaskDetailsPage.routeName: (context) => const TaskDetailsPage(),
                RegisterTaskActionPage.routeName: (context) =>
                    const RegisterTaskActionPage(),
                SubtractItemFromLocationPage.routeName: (context) =>
                    const SubtractItemFromLocationPage(),
                SelectNewAssetDataPage.routeName: (context) =>
                    const SelectNewAssetDataPage(),
                SettingsPage.routeName: (context) => const SettingsPage(),
                LanguageSettingsPage.routeName: (context) =>
                    const LanguageSettingsPage(),
                NotificationSettingsPage.routeName: (context) =>
                    const NotificationSettingsPage(),
                TaskActionDetailsPage.routeName: (context) =>
                    const TaskActionDetailsPage(),
                TaskArchivePage.routeName: (context) => const TaskArchivePage(),
                TemplatesManagementPage.routeName: (context) =>
                    const TemplatesManagementPage(),
                AddTaskTemplatePage.routeName: (context) =>
                    const AddTaskTemplatePage(),
                TaskTemplateDetailsPage.routeName: (context) =>
                    const TaskTemplateDetailsPage(),
                NotificationsPage.routeName: (context) =>
                    const NotificationsPage(),
                TaskArchiveForAssetPage.routeName: (context) =>
                    const TaskArchiveForAssetPage(),
              },
              // localization
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // locales
              supportedLocales: const [
                Locale('en', ''),
                Locale('pl', ''),
                Locale('da', ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
