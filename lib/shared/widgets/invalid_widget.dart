import 'package:flutter/material.dart';
import 'package:online_shop_app/shared/utils/colors.dart';

class InvalidWidget {
  Widget imageNotFound({required double height, required double fontSize}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image_not_supported_outlined,
          size: height,
          color: AppColors.darkGrey,
        ),
        Text(
          'Image not found',
          style: TextStyle(fontSize: fontSize),
        )
      ],
    );
  }

  Widget elementNotFound({required double height, required double width}) {
    return Container(
      margin: EdgeInsets.all(height == 0 ? 0 : 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightGrey,
      ),
      child: Container(height: height, width: width),
    );
  }
}
