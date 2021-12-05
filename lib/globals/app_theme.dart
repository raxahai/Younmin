import 'package:flutter/material.dart';
import 'package:younmin/globals/colors.dart';
import 'package:younmin/globals/styles/button_styles.dart';
import 'package:younmin/globals/styles/text_styles.dart';

class AppTheme {
  static Color primaryColor = YounminColors.primaryColor;

  static TextTheme _buildTextTheme(TextTheme? base) {
    return base!.copyWith(
      headline1: headline1Style,
      headline2: headline2Style,
      headline3: headline3Style,
      headline4: headline4Style,
      bodyText1: body1,
      bodyText2: body2,
    );
  }

  static ThemeData getTheme() {
    return customTheme();
  }

  static ThemeData customTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: YounminColors.appBarColor,
        elevation: 0,
      ),
      scaffoldBackgroundColor: YounminColors.backGroundColor,
      primaryColor: primaryColor,
      textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: YounminColors.secondaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: YounminColors.textFieldHintColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: YounminColors.textFieldColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff666666), width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: YounminColors.textFieldErrorColor,
            width: 1.5,
          ),
        ),
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    );
  }
}
