import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit()
      : super(Locale(
          kIsWeb ? 'en' : Platform.localeName.split('_')[0],
        ));

  void getInitLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('UC-lang');
    if (langCode != null) {
      emit(Locale(langCode.split('_')[0]));
    } else {
      emit(Locale(
        kIsWeb ? 'en' : Platform.localeName.split('_')[0],
      ));
    }
  }

  void changeLanguage(String langCode) async {
    emit(Locale(langCode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('UC-lang', langCode);
  }
}
