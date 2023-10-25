import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/product_portrait_layout.dart';
import 'package:online_shop_app/viewmodel/products/products_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecommendView extends ConsumerWidget {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductItems> _products = [];

    Widget _buildProduct() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: _products.isEmpty ? 4 : _products.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            mainAxisExtent: 32.h,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _products.isEmpty
                ? InvalidWidget().elementNotFound(height: 0, width: 0)
                : ProductPortraitLayout(
                    product: _products[index],
                    imageSize: 20.h,
                    margin: EdgeInsets.all(2),
                    nameTextStyle: AppTextStyles.mediumTextStyle,
                    priceTextStyle: AppTextStyles.mediumBoldOrangeTextStyle,
                    maxLines: 2,
                    loadingSize: 8.h,
                    errorSize: 5.h,
                  );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Recommendation')),
      body: ref.watch(productsViewModelProvider).when(
            data: (products) {
              _products = products;
              return SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  child: _buildProduct(),
                ),
              );
            },
            error: (error, _) => _buildProduct(),
            loading: () => SizedBox(),
          ),
    );
  }
}
