import 'package:flutter/material.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/utils/size_utils.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  final _appTheme = PrefUtils().getThemeData();

  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer.withOpacity(1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimaryContainer.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: appTheme.black900.withOpacity(0.3),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  LightCodeColors themeColor() => _getThemeColors();
  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.nearBlack,
          fontSize: 15.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
            color: appTheme.darkGrey,
            fontSize: 10.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400),
        displayMedium: TextStyle(
            color: appTheme.nearBlack,
            fontSize: 45.fSize,
            fontFamily: 'Inter',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
          color: appTheme.nearBlack,
          fontSize: 30.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.nearBlack,
          fontSize: 24.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: appTheme.nearBlack,
          fontSize: 15.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      );
}

class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color.fromRGBO(33, 37, 41, 100),
    onPrimary: Color(0XFFCF1717),
    onPrimaryContainer: Color.fromRGBO(248, 249, 250, 80),
  );
}

class LightCodeColors {
  Color get amber500 => const Color(0XFFFBBC05);

  Color get black900 => const Color(0XFF000000);

  Color get darkGrey => const Color.fromRGBO(52, 58, 64, 100);

  Color get nearBlack => const Color.fromRGBO(33, 37, 41, 100);

  Color get blueA200 => const Color(0XFF4285F4);

  Color get blueA700 => const Color(0XFF0866FF);

  Color get blueA200E0 => const Color(0XE04286F4);

  Color get gray100 => const Color(0XFFF5F5F5);

  Color get gray700 => const Color(0XFF5E5E5E);

  Color get green600 => const Color(0XFF34A853);

  Color get red500 => const Color(0XFFEA4335);
}
