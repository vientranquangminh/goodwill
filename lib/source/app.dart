import 'package:flutter/material.dart';
import 'package:goodwill/gen/fonts.gen.dart';
import 'package:goodwill/source/ui/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: FontFamily.workSans
      ),
      title: appLocalizations?.goodwill ?? '',
      home: const HomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
