import 'package:flutter/material.dart';

class KCheckboxTheme {
  KCheckboxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple;
        } else {
          return Colors.transparent;
        }
      }));

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.purple;
        } else {
          return Colors.transparent;
        }
      }));
}
