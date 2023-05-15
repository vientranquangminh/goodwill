import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_outline_button.dart';
import 'package:goodwill/source/resources/app_assets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDialogs {
  static Future<void> showOverWrongTimesLoginDialog(
      {required BuildContext context, required String title}) {
    return showDialog(
      context: context,
      builder: (BuildContext builder) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          titlePadding: const EdgeInsets.only(top: 26.5, bottom: 18.5),
          title: Image.asset(
            AppAssets.imgWarning,
            height: 35,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'OK',
                customFunction: () => context.pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showSingleOptionDialog(
      {required BuildContext context,
      required String message,
      required String buttonTitle,
      VoidCallback? buttonOnPressed,
      Widget? icon}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: <Widget>[
                  icon ??
                      Image.asset(
                        AppAssets.imgSuccessRound,
                        height: 35,
                      ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: buttonTitle,
                customFunction: () {
                  if (buttonOnPressed != null) buttonOnPressed();
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showTwoOptionDialog({
    required BuildContext context,
    required String message,
    required String rightButtonTitle,
    required String leftButtonTitle,
    Widget? title,
    VoidCallback? rightOnPressed,
    VoidCallback? leftOnPressed,
    Widget? icon,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon ??
                  Column(
                    children: <Widget>[
                      Image.asset(
                        AppAssets.imgWarning,
                        height: 35,
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: PrimaryOutlineButton(
                      text: leftButtonTitle,
                      customFunction: () {
                        if (leftOnPressed != null) leftOnPressed();
                        context.pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: rightButtonTitle,
                      customFunction: () {
                        if (rightOnPressed != null) rightOnPressed();
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showIosDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String firstButtonTitle,
    required String secondButtonTitle,
    VoidCallback? firstOnPressed,
    VoidCallback? secondOnPressed,
  }) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                  onPressed: () {
                    if (firstOnPressed != null) firstOnPressed();
                  },
                  child: Text(firstButtonTitle)),
              CupertinoDialogAction(
                  onPressed: () {
                    if (secondOnPressed != null) secondOnPressed();
                  },
                  child: Text(secondButtonTitle)),
            ],
          );
        });
  }
}
