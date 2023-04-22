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

  void pushNamed(String routeName) => Navigator.pushNamed(this, routeName);

  void pushNamedWithParam(String routeName, Object? param) =>
      Navigator.pushNamed(this, routeName, arguments: param);

  void pop() => Navigator.pop(this);

  void popUntil(String routeName) =>
      Navigator.popUntil(this, ModalRoute.withName(routeName));

  void pushAndRemoveUntil(String routeName) => Navigator.of(this)
      .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

  void pushReplacementNamed(String routeName) => Navigator.pushReplacementNamed(this, routeName);

  Object? getParam() =>
      (ModalRoute.of(this)?.settings.arguments ?? <String, dynamic>{});
}
