import 'package:flutter/material.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

class CustomTextStyles {
  static TextStyle get grey => TextStyle(
        color: appTheme.gray100,
        fontSize: 20.fSize,
        fontWeight: FontWeight.bold,
      ).inter;

  static TextStyle get aBeeZeeBlack900 => TextStyle(
        color: appTheme.black900,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).inter;

//Body text style
  static TextStyle get bodyMediumBlack900 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.3),
      );

  static TextStyle get bodyNearDark => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.nearBlack,
      );

  static get bodyMediumInter => theme.textTheme.bodyLarge!.inter;

  static TextStyle get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
      );

  static get bodyLargeInter => theme.textTheme.bodyLarge!.inter;

  static TextStyle get bodySmall11 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 11.fSize,
      );

  static TextStyle get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 15.fSize,
      );

  static get bodySmallInter => theme.textTheme.bodySmall?.inter;

  static TextStyle get bodySmallInter12 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        fontSize: 12.fSize,
      );
  static TextStyle get bodySmallInterLight =>
      theme.textTheme.bodySmall!.inter.copyWith(
        fontWeight: FontWeight.w300,
      );

  static TextStyle get titleLargeFredokaOneOnPrimaryContainer =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static get titleLargeInter => theme.textTheme.titleLarge!.inter;
}
