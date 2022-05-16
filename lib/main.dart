import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/authentication/presentation/pages/authentication_page.dart';
import 'package:under_control_v2/features/authentication/presentation/pages/email_confirmation_page.dart';
import 'package:under_control_v2/features/core/constants/app_colors.dart';
import 'package:under_control_v2/features/core/presentation/pages/home_page.dart';
import 'package:under_control_v2/features/core/utils/custom_page_transition.dart';
import 'package:under_control_v2/features/core/utils/material_color_generator.dart';

import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

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
    return BlocProvider(
      create: (context) => getIt<AuthenticationBloc>(),
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
              backgroundColor: AppColors.darkAppBarBackground),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print('XXX this is my state $state');
            if (state is Authenticated) {
              return const HomePage();
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
