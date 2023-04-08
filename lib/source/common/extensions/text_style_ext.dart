import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/resources/dimens.dart';

extension PlatFormThemeDataExtension on BuildContext {
  TextStyle? get blackS12W500 => platformThemeData(
        this,
        material: (data) => data.textTheme.labelLarge?.copyWith(
          color: ColorName.black,
          fontSize: Dimens.fontSize12,
          fontWeight: FontWeight.w500,
        ),
        cupertino: (data) => data.textTheme.textStyle.copyWith(
          color: ColorName.black,
          fontSize: Dimens.fontSize12,
          fontWeight: FontWeight.w500,
        ),
      );
}
