import 'dart:ui';

import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = Locale(window.locale.toString().split('_')[0]);

  Locale get locale => _locale;

  void setLocale(Locale locale){
    _locale = locale;
    notifyListeners();
  }
}