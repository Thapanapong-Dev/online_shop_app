import 'package:flutter/material.dart';
import 'package:online_shop_app/shared/utils/colors.dart';

class Properties {
  Decoration cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: AppColors.grey,
          blurRadius: 5,
          offset: Offset(1, 1),
        )
      ],
    );
  }
}
