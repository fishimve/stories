import 'package:flutter/material.dart';
import 'package:stories/interface/shared/styles.dart';

import 'colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    dividerColor: AppColors.secondaryLight.withOpacity(.60),
    canvasColor: Colors.black.withOpacity(.45),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: AppColors.backgroundLight,
      secondary: AppColors.primaryLight,
    ),
    brightness: Brightness.light,
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.secondaryLight,
      unselectedLabelColor: AppColors.secondaryLight,
      labelStyle: headline2Style,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: AppColors.backgroundLight,
      titleTextStyle: headline3Style,
      iconTheme: IconThemeData(
        color: AppColors.primaryLight,
        size: 25,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    dividerColor: AppColors.secondaryDark.withOpacity(.60),
    canvasColor: Colors.white.withOpacity(.45),
    brightness: Brightness.dark,
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.secondaryDark,
      unselectedLabelColor: AppColors.secondaryDark,
      labelStyle: headline2Style,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: AppColors.backgroundDark,
      titleTextStyle: headline3Style,
      iconTheme: IconThemeData(
        color: AppColors.primaryDark,
        size: 25,
      ),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          secondary: AppColors.primaryDark,
        )
        .copyWith(background: AppColors.backgroundDark),
  );
}
