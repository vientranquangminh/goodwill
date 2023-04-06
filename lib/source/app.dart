import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/start_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appLocalizations?.goodwill ?? '',
      home: const StartApp(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
