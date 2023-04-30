
import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/page/profile/change_language/language_enum.dart';

extension LocaleExt on Locale {

  bool isVi(LanguageEnum language) => this == Locale(language.vie);

  bool isEn(LanguageEnum language) => this == Locale(language.eng);

}
