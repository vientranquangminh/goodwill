import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorName.black,
        title: AppLocalizations.of(context)?.goodwill ?? '',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(appLocalizations?.startPageOfGoodWill ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CustomElevatedButton(
              text: appLocalizations?.start ?? '',
              textColor: ColorName.white,
              buttonColor: ColorName.black,
              customFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyPageController()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
