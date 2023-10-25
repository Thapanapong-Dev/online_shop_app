import 'package:flutter/material.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({super.key, required this.quantity});
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 5.h,
      margin: EdgeInsets.only(left: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        shape: BoxShape.circle,
      ),
      child: Text(
        quantity.toString(),
        style: AppTextStyles.mediumBoldTextStyle,
      ),
    );
  }
}
