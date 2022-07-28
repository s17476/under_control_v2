import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_management_page.dart';
import 'package:under_control_v2/features/locations/presentation/pages/location_management_page.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/user_details_page.dart';

import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/email_confirmation_page.dart';
import 'features/company_profile/presentation/blocs/company_management/company_management_bloc.dart';
import 'features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'features/company_profile/presentation/pages/add_company_page.dart';
import 'features/company_profile/presentation/pages/assign_company_page.dart';
import 'features/core/presentation/pages/error_page.dart';
import 'features/core/presentation/pages/home_page.dart';
import 'features/core/presentation/pages/loading_page.dart';
import 'features/core/themes/themes.dart';
import 'features/core/utils/custom_page_transition.dart';
import 'features/core/utils/error_message_handler.dart';
import 'features/core/utils/material_color_generator.dart';
import 'features/groups/presentation/blocs/group/group_bloc.dart';
import 'features/groups/presentation/pages/add_group_page.dart';
import 'features/locations/presentation/blocs/bloc/location_bloc.dart';
import 'features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';
import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'features/user_profile/presentation/pages/add_user_profile_page.dart';
import 'features/user_profile/presentation/pages/not_approved_page.dart';
import 'firebase_options.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const App());
}

class App extends StatelessWidget
    with CustomPageTransition, MaterialColorGenerator {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthenticationBloc>()),
        BlocProvider(create: (context) => getIt<UserProfileBloc>()),
        BlocProvider(create: (context) => getIt<UserManagementBloc>()),
        BlocProvider(create: (context) => getIt<CompanyProfileBloc>()),
        BlocProvider(create: (context) => getIt<CompanyManagementBloc>()),
        BlocProvider(create: (context) => getIt<LocationBloc>()),
        BlocProvider(create: (context) => getIt<GroupBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UnderControl',
        theme: Themes().darkTheme(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            // user authenticated
            if (state is Authenticated) {
              return BlocConsumer<UserProfileBloc, UserProfileState>(
                listener: (context, state) {
                  showSnackBar(state, context);
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case Approved:
                      return const HomePage();
                    case NoUserProfileError:
                      return const AddUserProfilePage();
                    case Loading:
                      return const LoadingPage();
                    case NoCompany:
                      return const AssignCompanyPage();
                    case NotApproved:
                      return const NotApprovedPage();
                    default:
                      return const ErrorPage();
                  }
                },
              );
              // awaiting email berification
            } else if (state is AwaitingVerification) {
              return const EmailConfirmationPage();
              // user not authenticated
            } else {
              return const AuthenticationPage();
            }
          },
        ),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          AuthenticationPage.routeName: (context) => const AuthenticationPage(),
          AddCompanyPage.routeName: (context) => const AddCompanyPage(),
          LocationManagementPage.routeName: (context) =>
              const LocationManagementPage(),
          GroupManagementPage.routeName: (context) =>
              const GroupManagementPage(),
          AddGroupPage.routeName: (context) => const AddGroupPage(),
          GroupDetailsPage.routeName: (context) => const GroupDetailsPage(),
          UserDetailsPage.routeName: (context) => const UserDetailsPage(),
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('pl', ''),
        ],
      ),
    );
  }
}
