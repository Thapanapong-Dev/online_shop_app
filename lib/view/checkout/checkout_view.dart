import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/properties.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math;

class CheckoutView extends ConsumerWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget _buildCheckoutBtn() {
      return Container(
        height: 8.h,
        padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 4.w),
        child: ElevatedButton(
          child: Text('Checkout'),
          onPressed: () => Navigator.pushNamed(context, Routes.PAYMENT),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            shadowColor: AppColors.grey,
            elevation: 0.5,
            foregroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: AppTextStyles.sectionNameTextStyle,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        elevation: 0,
        toolbarHeight: 5.h,
      ),
      body: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.TAX_INVOICE),
        child: Container(
          decoration: Properties().cardDecoration(),
          width: 100.w,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax invoice',
                style: AppTextStyles.mediumTextStyle,
              ),
              Transform.rotate(
                angle: 180 * math.pi / 120,
                child: Icon(
                  Icons.expand_circle_down_outlined,
                  color: AppColors.orange,
                ),
              ),
              // Icon(Icons.expand_circle_down_outlined),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCheckoutBtn(),
    );
  }
}
