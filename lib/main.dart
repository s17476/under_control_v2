import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart';
import 'package:under_control_v2/features/authentication/presentation/pages/authentication_page.dart';
import 'package:under_control_v2/features/core/presentation/pages/home_page.dart';

import 'features/authentication/domain/usecases/signin.dart';
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

class App extends StatelessWidget {
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
        routes: {
          SplashPage.routeName: (ctx) => const SplashPage(),
          HomePage.routeName: (ctx) => const HomePage(),
          AuthenticationPage.routeName: (ctx) => const AuthenticationPage(),
        },
      ),
    );
  }
}
