import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/shared/utils/utils.dart';
import 'package:online_shop_app/viewmodel/cart/product_selected_view_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentView extends ConsumerWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _productSelected = ref.watch(productSelectedProvider);

    Widget _buildProductSummary() {
      return Scrollbar(
        thumbVisibility: true,
        child: Container(
          height: 15.h,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _productSelected.products!.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final product = _productSelected.products![index];
              return Container(
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60.w,
                              child: Text(
                                product.name!,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: AppTextStyles.normalTextStyle,
                              ),
                            ),
                            Text(
                              '${product.qty}x${Utils().priceFormat(product.price)}',
                              style: AppTextStyles.normalTextStyle,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '${Utils().priceFormatWithSymbol(product.totalByItem)}',
                      style: AppTextStyles.normalBoldTextStyle,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }

    Widget _buildTotalPrice() {
      return Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: AppTextStyles.largeBoldTextStyle,
            ),
            Text(
              '${Utils().priceFormatWithSymbol(_productSelected.totalPrice)}',
              style: AppTextStyles.largeBoldTextStyle,
            ),
          ],
        ),
      );
    }

    Widget _buildQRCode() {
      return QrImageView(
        data:
            'https://payment-api.yimplatform.com/checkout?price=${_productSelected.totalPrice}',
        version: QrVersions.auto,
        size: 60.w,
        eyeStyle: QrEyeStyle(
          eyeShape: QrEyeShape.circle,
          color: AppColors.black,
        ),
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.circle,
          color: AppColors.black,
        ),
        gapless: true,
      );
    }

    Widget _buildHeader() {
      return Column(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.orange,
            size: 20.w,
          ),
          Text(
            'Thank you for your order!',
            style: AppTextStyles.thankYouTextStyle,
          ),
          Text(
            'Scan to pay',
            style: AppTextStyles.largeBoldTextStyle,
          )
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, Routes.INITIAL);
        ref.read(productSelectedProvider.notifier).removeAll();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 5.h,
        ),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              SizedBox(height: 5.h),
              _buildQRCode(),
              SizedBox(height: 5.h),
              _buildProductSummary(),
              _buildTotalPrice(),
            ],
          ),
        ),
      ),
    );
  }
}
