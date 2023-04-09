import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

class GetGreeting{
  static String greeting(BuildContext context) {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return context.localizations.goodMorning;
    }
    if (hour < 17) {
      return context.localizations.goodAfternoon;
    }
    return context.localizations.goodEvening;
  }
}