import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: CustomColors.primary,
      secondary: CustomColors.primary,
    ),
    splashColor: CustomColors.primary,
    textTheme: AppTypography.lightTheme,
    searchBarTheme: SearchBarThemeData(
      padding:
          WidgetStateProperty.resolveWith((state) => const EdgeInsets.all(2)),
      elevation: WidgetStateProperty.resolveWith<double>((state) => 1),
      shape: WidgetStateProperty.resolveWith((state) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey)
          )),
    ),
    cardTheme: CardTheme(
      surfaceTintColor: CustomColors.lightPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
