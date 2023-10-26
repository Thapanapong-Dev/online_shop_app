import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/product_portrait_layout.dart';
import 'package:online_shop_app/viewmodel/products/products_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecommendElement extends ConsumerWidget {
  const RecommendElement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductItems> _products = [];

    Widget _buildHeader() {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommendation',
              style: AppTextStyles.sectionNameTextStyle,
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, Routes.RECOMMEND),
              child: Text('View all'),
            ),
          ],
        ),
      );
    }

    Widget _buildProduct() {
      return Container(
        height: 20.h,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: min(_products.length, 4),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 5 : 0,
                right: index == 3 ? 5 : 0,
              ),
              child: ProductPortraitLayout(
                product: _products[index],
                imageSize: 10.h,
                margin: EdgeInsets.all(5),
                nameTextStyle: AppTextStyles.normalTextStyle,
                priceTextStyle: AppTextStyles.normalBoldOrangeTextStyle,
                maxLines: 1,
                loadingSize: 5.h,
                errorSize: 4.h,
              ),
            );
          },
        ),
      );
    }

    return ref.watch(productsProvider).when(
          data: (products) {
            _products = products;
            return Column(
              children: [
                _buildHeader(),
                _buildProduct(),
              ],
            );
          },
          error: (error, _) => InvalidWidget().elementNotFound(
            height: 30.h,
            width: 100.w,
          ),
          loading: () => SizedBox(),
        );
  }
}
