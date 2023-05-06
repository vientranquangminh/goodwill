import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/ui/page/auth_wrapper/auth_wrapper.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorName.black,
        title: appLocalizations?.goodwill ?? '',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(appLocalizations?.startPageOfGoodWill ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: PrimaryButton(
              text: appLocalizations?.start ?? '',
              textColor: ColorName.white,
              buttonColor: ColorName.black,
              customFunction: () {
                if (kIsWeb) {
                  context.pushNamed(Routes.adminLogin);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AuthWrapper(),
                      ));
                }
                },
            ),
          )
        ],
      ),
    );
  }
}
