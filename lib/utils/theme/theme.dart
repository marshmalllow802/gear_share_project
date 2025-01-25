import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/theme/custom_themes/appbar_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/chip_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/text_field_theme.dart';
import 'package:gear_share_project/utils/theme/custom_themes/text_theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.white,
    textTheme: KTextTheme.lightTextTheme,
    chipTheme: KChipTheme.lightChipTheme,
    appBarTheme: KAppBarTheme.lightAppBarTheme,
    checkboxTheme: KCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: KBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.black,
    textTheme: KTextTheme.darkTextTheme,
    chipTheme: KChipTheme.darkChipTheme,
    appBarTheme: KAppBarTheme.darkAppBarTheme,
    checkboxTheme: KCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: KBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.darkInputDecorationTheme,
  );
}
