import 'package:flutter/material.dart';
import '../utils/material_color_generator.dart';

class Themes with MaterialColorGenerator {
  /// Dark theme for UnderControl app.
  ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(0, 240, 130, 100),
        primarySwatch: createMaterialColor(
          const Color.fromRGBO(0, 240, 130, 100),
        ),
        brightness: Brightness.dark,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF191919),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
        cardColor: const Color.fromARGB(255, 50, 50, 50),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 40, 40, 40),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: const Color.fromRGBO(0, 240, 130, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      );
}
