import 'package:flutter/material.dart';
import '../utils/material_color_generator.dart';

class Themes with MaterialColorGenerator {
  /// Dark theme for UnderControl app.
  ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(0, 240, 130, 100),
        // primaryColor: const Color.fromARGB(255, 28, 154, 97),
        primarySwatch: createMaterialColor(
          const Color.fromRGBO(0, 240, 130, 100),
        ),
        dividerTheme: const DividerThemeData(color: Colors.white12),

        // colorScheme: ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: const Color.fromRGBO(0, 240, 130, 100),
        //   onPrimary: Colors.grey.shade200,
        //   secondary: const Color.fromRGBO(0, 240, 130, 100),
        //   onSecondary: Colors.grey.shade200,
        //   error: const Color.fromARGB(255, 200, 46, 35),
        //   onError: Colors.grey.shade200,
        //   background: const Color.fromARGB(255, 30, 30, 30),
        //   onBackground: Colors.grey.shade200,
        //   surface: const Color.fromARGB(255, 50, 50, 50),
        //   onSurface: Colors.grey.shade300,
        // ),
        errorColor: Color.fromARGB(255, 189, 49, 39),
        brightness: Brightness.dark,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF191919),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
        cardColor: const Color.fromARGB(255, 50, 50, 50),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 40, 40, 40),
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   systemNavigationBarColor: Color.fromRGBO(40, 40, 40, 1),
          //   systemNavigationBarIconBrightness: Brightness.light,
          //   statusBarColor: Color.fromRGBO(40, 40, 40, 1),
          //   statusBarBrightness: Brightness.dark,
          // ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(0, 240, 130, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade800,
          errorStyle: const TextStyle(
            color: Color.fromARGB(255, 194, 56, 46),
          ),
          labelStyle: TextStyle(color: Colors.grey.shade300),
          floatingLabelStyle: TextStyle(color: Colors.grey.shade400),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(0, 240, 130, 100),
          selectionColor: Color.fromRGBO(0, 240, 130, 100),
          selectionHandleColor: Color.fromRGBO(0, 240, 130, 100),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 28, 154, 97),
          foregroundColor: Colors.white,
        ),
        highlightColor: Colors.amber,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromRGBO(0, 240, 130, 100),
            ),
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color.fromARGB(255, 50, 50, 50),
        ),
        canvasColor: const Color.fromARGB(255, 50, 50, 50),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromRGBO(0, 240, 130, 100),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateColor.resolveWith(
            (states) => Colors.grey.shade100,
          ),
        ),
      );
}
