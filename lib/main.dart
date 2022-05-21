import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/add_user_profile_page.dart';

import 'features/authentication/presentation/pages/authentication_page.dart';
import 'features/authentication/presentation/pages/email_confirmation_page.dart';
import 'features/core/constants/app_colors.dart';
import 'features/core/presentation/pages/error_page.dart';
import 'features/core/presentation/pages/home_page.dart';
import 'features/core/utils/custom_page_transition.dart';
import 'features/core/utils/material_color_generator.dart';
import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import 'features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'firebase_options.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
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
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UnderControl',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: createMaterialColor(AppColors.greenControl),
          drawerTheme: const DrawerThemeData(
            backgroundColor: AppColors.darkBackground,
          ),
          scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.darkAppBarBackground,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is Approved) {
                    return const HomePage();
                  } else if (state is UserProfileError) {
                    return const AddUserProfilePage();
                  } else {
                    return ErrorPage();
                  }
                },
              );
            } else if (state is AwaitingVerification) {
              return const EmailConfirmationPage();
            } else {
              return const AuthenticationPage();
            }
          },
        ),
        routes: {
          HomePage.routeName: (ctx) => const HomePage(),
          AuthenticationPage.routeName: (ctx) => const AuthenticationPage(),
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
