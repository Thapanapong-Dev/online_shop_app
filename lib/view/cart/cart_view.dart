import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/properties.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/shared/utils/utils.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/loading_widget.dart';
import 'package:online_shop_app/shared/widgets/product_quantity_widget.dart';
import 'package:online_shop_app/view/product/product_view.dart';
import 'package:online_shop_app/viewmodel/cart/product_selected_view_model.dart';
import 'package:online_shop_app/viewmodel/cart/products_cart_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _productsCart = ref.watch(productsCartProvider);
    final _productSelected = ref.watch(productSelectedProvider);

    Widget _buildCheckout() {
      return Container(
        height: 7.h,
        color: AppColors.lightOrange,
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${_productSelected.totalPrice}',
              style: AppTextStyles.largeBoldTextStyle,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.CHECKOUT),
              child: Text('Checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                shadowColor: AppColors.grey,
                elevation: 2,
                foregroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: AppTextStyles.sectionNameTextStyle,
              ),
            )
          ],
        ),
      );
    }

    Widget _buildPlus(ProductItems product) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        child: SizedBox.fromSize(
          size: Size(5.h, 5.h),
          child: ClipOval(
            child: Material(
              color: AppColors.lightOrange,
              child: InkWell(
                splashColor: AppColors.orange,
                onTap: () => ref
                    .read(productSelectedProvider.notifier)
                    .update(product: product, quantity: 1),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildMinus(ProductItems product) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        child: SizedBox.fromSize(
          size: Size(5.h, 5.h),
          child: ClipOval(
            child: Material(
              color: AppColors.lightGrey,
              child: InkWell(
                splashColor: AppColors.orange,
                onTap: () => ref
                    .read(productSelectedProvider.notifier)
                    .update(product: product, quantity: -1),
                child: Icon(Icons.remove),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildQuantityOperation({required ProductItems product}) {
      final quantity =
          ref.watch(productSelectedProvider.notifier).getQuantity(product.id!);
      return Row(
        children: [
          quantity == 0 ? SizedBox() : _buildMinus(product),
          ProductQuantity(quantity: quantity),
          _buildPlus(product),
        ],
      );
    }

    Widget _buildProduct(ProductItems product) {
      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: Properties().cardDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.w,
              height: 12.h,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(
                    context,
                    Routes.PRODUCT,
                    arguments: ProductArguments(product),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl!,
                  placeholder: (context, url) => LoadingWidget().LoadingElement(
                    size: 5.h,
                    lineWidth: 5.h / 10,
                  ),
                  errorWidget: (context, url, error) =>
                      InvalidWidget().imageNotFound(
                    height: 4.h,
                    fontSize: 4.h / 2.5,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4, left: 10),
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: AppTextStyles.mediumTextStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${Utils().priceFormatWithSymbol(product.price)}',
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: AppTextStyles.mediumBoldOrangeTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _productsCart.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _productsCart.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final product = _productsCart[index];
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Slidable(
                            child: Stack(
                              children: [
                                _buildProduct(product),
                                Positioned(
                                  right: 16,
                                  bottom: 10,
                                  child: _buildQuantityOperation(
                                    product: product,
                                  ),
                                )
                              ],
                            ),
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    ref
                                        .read(productSelectedProvider.notifier)
                                        .removeProductSelectedAndProductInCart(
                                            product: product);
                                    ;
                                  },
                                  icon: Icons.delete,
                                  foregroundColor: AppColors.white,
                                  backgroundColor: AppColors.red,
                                  label: 'Delete',
                                  autoClose: true,
                                  spacing: 2,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10)),
                                  padding: EdgeInsets.all(5),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_rounded,
                      color: AppColors.grey,
                      size: 18.h,
                    ),
                    Text(
                      'Shopping now!',
                      style: AppTextStyles.mediumBoldDarkGreyTextStyle,
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar:
          _productSelected.totalPrice == 0 ? SizedBox() : _buildCheckout(),
    );
  }
}
