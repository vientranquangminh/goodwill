import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/locale_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/ui/page/profile/change_language/language_enum.dart';
import 'package:goodwill/source/ui/page/profile/change_language/language_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: PlatformIconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorName.black,
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorName.white,
        title: Text(
          context.localizations.changeLanguage,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  log(LanguageEnum.en.toString());
                  languageProvider
                      .setLocale(Locale(LanguageEnum.en.eng));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.changeLanguage.ukFlag.image(
                            height: 36.h,
                            width: 36.w,
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          Text('English', style: context.blackS20W700),
                        ],
                      ),
                      if (languageProvider.locale.isEn(LanguageEnum.en))
                        const Icon(
                          Icons.check,
                          color: ColorName.black,
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  languageProvider
                      .setLocale(Locale(LanguageEnum.vi.vie));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.changeLanguage.vietnamFlag.image(
                            height: 36.h,
                            width: 36.w,
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          Text('Vietnamese', style: context.blackS20W700),
                        ],
                      ),
                      
                      if (languageProvider.locale.isVi(LanguageEnum.vi))
                        const Icon(
                          Icons.check,
                          color: ColorName.black,
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
