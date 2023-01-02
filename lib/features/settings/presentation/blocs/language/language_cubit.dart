import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(null);

  void getInitLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('UC-lang');
    if (langCode != null) {
      emit(Locale(langCode));
    }
  }

  void changeLanguage(String langCode) async {
    emit(Locale(langCode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('UC-lang', langCode);
  }
}
