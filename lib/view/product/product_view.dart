import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/shared/utils/utils.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/loading_widget.dart';
import 'package:online_shop_app/shared/widgets/notification_widget.dart';
import 'package:online_shop_app/viewmodel/cart/cart_view_model.dart';
import 'package:online_shop_app/viewmodel/saved/saved_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductArguments {
  ProductArguments(this.product);
  final ProductItems product;
}

class ProductView extends ConsumerStatefulWidget {
  const ProductView({super.key});

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as ProductArguments;

    Widget _buildProductImage() {
      return Container(
        width: 100.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(5.h),
          ),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 5,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: CachedNetworkImage(
            imageUrl: _args.product.imageUrl!,
            placeholder: (context, url) =>
                LoadingWidget().LoadingElement(size: 8.h, lineWidth: 10),
            errorWidget: (context, url, error) =>
                InvalidWidget().imageNotFound(height: 6.h, fontSize: 14),
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    Widget _buildSavedIcon() {
      return GestureDetector(
        onTap: () {
          setState(() {});
          final isSaved =
              ref.read(savedViewModelProvider.notifier).tab(_args.product);
          AppNotification().savedNotification(
            name: _args.product.name!,
            isSaved: isSaved,
            context: context,
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: 9.h,
          width: 9.h,
          decoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          child: ref.watch(savedViewModelProvider).contains(_args.product.id)
              ? Icon(
                  Icons.favorite_rounded,
                  color: AppColors.red,
                  size: 40,
                )
              : Icon(
                  Icons.favorite_rounded,
                  color: AppColors.white,
                  size: 40,
                ),
        ),
      );
    }

    Widget _buildProductDetail() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(children: [
                  _buildProductImage(),
                  SizedBox(height: 3.h),
                ]),
                Positioned(
                  right: 10,
                  bottom: 0,
                  child: _buildSavedIcon(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
              child: Text(
                '${_args.product.name}',
                style: AppTextStyles.largeTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text(
                '${Utils().priceFormatWithSymbol(_args.product.price)}',
                style: AppTextStyles.largeBoldOrangeTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildAddToCartButton() {
      return Container(
        width: 88.w,
        height: 8.h,
        padding: EdgeInsets.only(bottom: 2.h),
        child: ElevatedButton(
          child: Text('Add to Cart'),
          onPressed: () {
            final current_quantity = ref
                .read(cartViewModelProvider.notifier)
                .getProductQuantity(_args.product.id!);
            final updated_quantity = ref
                .read(cartViewModelProvider.notifier)
                .update(product: _args.product, quantity: current_quantity + 1);
            AppNotification().addToCartNotification(
              name: _args.product.name!,
              quantity: updated_quantity,
              context: context,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            shadowColor: AppColors.grey,
            elevation: 0.5,
            foregroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: AppTextStyles.sectionNameTextStyle,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(elevation: 0, toolbarHeight: 5.h),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildProductDetail()),
          _buildAddToCartButton(),
        ],
      ),
    );
  }
}
