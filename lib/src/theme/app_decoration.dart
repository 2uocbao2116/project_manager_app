import 'package:flutter/material.dart';
import 'package:projectmanager/src/theme/theme_helper.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get fillBlueA => BoxDecoration(
        color: appTheme.blueA700,
      );
  static BoxDecoration get fillBlueA200 => BoxDecoration(
        color: appTheme.blueA200,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
      );
  static BoxDecoration get fillGray700 => BoxDecoration(
        color: appTheme.gray700.withOpacity(0.2),
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimaryContainer1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get outlineBlack => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.4),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  static BorderRadius get circleBorder15 => BorderRadius.circular(
        15.h,
      );

  static BorderRadius get customBorderB16 => BorderRadius.vertical(
        bottom: Radius.circular(16.h),
      );
  static BorderRadius get circleBorder46 => BorderRadius.circular(
        46.h,
      );
  static BorderRadius get circleBorder5 => BorderRadius.circular(
        5.h,
      );
  static BorderRadius get customBorderBL10 => BorderRadius.vertical(
        bottom: Radius.circular(10.h),
      );

  static BorderRadius get customBorderT15 => BorderRadius.vertical(
        top: Radius.circular(15.h),
      );
  static BorderRadius get customBorderTL50 => BorderRadius.only(
        topLeft: Radius.circular(50.h),
        bottomRight: Radius.circular(50.h),
      );

  static BorderRadius get rounderBorder5 => BorderRadius.circular(5.h);

  static BorderRadius get rounderBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder74 => BorderRadius.circular(
        74.h,
      );
}
