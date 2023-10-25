import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppNotification {
  void addToCartNotification({
    required String name,
    required int quantity,
    required BuildContext context,
  }) {
    InAppNotification.show(
      child: Container(
        height: 10.h,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.lightOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add ${name.length < 20 ? name : name.substring(0, 20) + '...'} to cart',
                ),
                Text(
                  'Current quantity is $quantity',
                  style: AppTextStyles.mediumBoldTextStyle,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: AppColors.orange,
                size: 5.h,
              ),
            ),
          ],
        ),
      ),
      context: context,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOutCubic,
      dismissCurve: Curves.easeOutCubic,
    );
  }

  void savedNotification({
    required String name,
    required bool isSaved,
    required BuildContext context,
  }) {
    InAppNotification.show(
      child: Container(
        height: 10.h,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.lightOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${name.length < 15 ? name : name.substring(0, 15) + '...'} ${isSaved ? 'is saved' : 'is not saved'}',
                  style: AppTextStyles.mediumTextStyle,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: isSaved
                  ? Icon(
                      Icons.favorite_rounded,
                      color: AppColors.red,
                      size: 5.h,
                    )
                  : Icon(
                      Icons.heart_broken_rounded,
                      color: AppColors.red,
                      size: 5.h,
                    ),
            ),
          ],
        ),
      ),
      context: context,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOutCubic,
      dismissCurve: Curves.easeOutCubic,
    );
  }
}
