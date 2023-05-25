import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/gen/fonts.gen.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/article_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
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
            ),
            StreamProvider<List<UserProfile>>(
              create: (context) => UserProfileService.getAllUserProfiles(),
              initialData: const [],
              catchError: (context, error) {
                debugPrint('Error fetching users: $error');
                return [];
              },
            ),
            StreamProvider<List<ArticleModel>?>(
              create: (context) => ArticleService.getStreamAllArticles(),
              initialData: const [],
              catchError: (context, error) {
                debugPrint('Error fetching articles: $error');
                return [];
              },
            ),
            StreamProvider<List<ProductModel>?>(
              create: (context) => ProductService.getStreamAllProductsS(),
              initialData: const [],
              catchError: (context, error) {
                debugPrint('Error fetching products: $error');
                return [];
              },
            ),
            StreamProvider<UserProfile?>(
              create: (context) => UserProfileService.getMyUserProfileStream(),
              initialData: null,
              catchError: (context, error) {
                debugPrint('Error fetching products: $error');
                return null;
              },
            )
          ],
          builder: (context, child) {
            final languageProvider = context.watch<LanguageProvider>();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashScreen,
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
