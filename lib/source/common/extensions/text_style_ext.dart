import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/resources/dimens.dart';

extension PlatFormThemeDataExtension on BuildContext {
  TextStyle? get appBarTextStyle => platformThemeData(
        this,
        material: (data) => data.textTheme.labelLarge?.copyWith(
          color: ColorName.white,
          fontSize: Dimens.fontSize16,
          fontWeight: FontWeight.w800,
        ),
        cupertino: (data) => data.textTheme.textStyle.copyWith(
          color: ColorName.white,
          fontSize: Dimens.fontSize16,
          fontWeight: FontWeight.w800,
        ),
      );

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

  TextStyle? get blackS20W700 => platformThemeData(
        this,
        material: (data) => data.textTheme.labelLarge?.copyWith(
          color: ColorName.black,
          fontSize: Dimens.fontSize16,
          fontWeight: FontWeight.w700,
        ),
        cupertino: (data) => data.textTheme.textStyle.copyWith(
          color: ColorName.black,
          fontSize: Dimens.fontSize16,
          fontWeight: FontWeight.w700,
        ),
      );
}
