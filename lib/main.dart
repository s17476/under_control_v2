import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/authentication/presentation/pages/authentication_page.dart';
import 'package:under_control_v2/features/authentication/presentation/pages/email_confirmation_page.dart';
import 'package:under_control_v2/features/core/presentation/pages/home_page.dart';
import 'package:under_control_v2/features/core/utils/custom_page_transition.dart';

import 'features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/core/presentation/pages/splash_page.dart';

import 'firebase_options.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureInjection();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    // statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const App());
}

class App extends StatelessWidget with CustomPageTransition {
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
          primarySwatch: Colors.green,
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
