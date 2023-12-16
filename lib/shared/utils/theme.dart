import 'package:flutter/material.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';

final appTheme = ThemeData(
  fontFamily: kodchasan,
  appBarTheme: AppBarTheme(
    color: AppColors.white,
    shadowColor: AppColors.grey,
    elevation: 0.5,
    centerTitle: true,
    foregroundColor: AppColors.black,
    titleTextStyle: AppTextStyles.appBarNameTextStyle,
  ),
  scaffoldBackgroundColor: AppColors.lighterGrey,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.lighterGrey,
      shadowColor: AppColors.transparent,
      elevation: 0.5,
      foregroundColor: AppColors.orange,
      textStyle: AppTextStyles.normalBoldOrangeTextStyle,
    ),
  ),
);
