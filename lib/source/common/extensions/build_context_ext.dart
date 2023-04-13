import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return localizations.goodMorning;
    }
    if (hour < 17) {
      return localizations.goodAfternoon;
    }
    return localizations.goodEvening;
  }
}