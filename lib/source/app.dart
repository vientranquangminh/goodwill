import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/gen/fonts.gen.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/ui/page/profile/change_language/language_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        // return
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => LanguageProvider(),
            )
          ],
          builder: (context, child) {
            final languageProvider = context.watch<LanguageProvider>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.startApp,
              locale: languageProvider.locale,
              routes: customRoutes,
              theme: ThemeData(
                  fontFamily: FontFamily.workSans,
                  appBarTheme: AppBarTheme(
                      backgroundColor: ColorName.black,
                      elevation: 0.0,
                      titleTextStyle: context.appBarTextStyle)),
              title: appLocalizations?.goodwill ?? '',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
