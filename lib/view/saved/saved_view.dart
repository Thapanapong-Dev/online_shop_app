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
import 'package:online_shop_app/shared/widgets/notification_widget.dart';
import 'package:online_shop_app/shared/widgets/product_quantity_widget.dart';
import 'package:online_shop_app/view/product/product_view.dart';
import 'package:online_shop_app/viewmodel/cart/product_selected_view_model.dart';
import 'package:online_shop_app/viewmodel/saved/products_saved_view_model.dart';
import 'package:online_shop_app/viewmodel/saved/saved_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SavedView extends ConsumerWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _products = ref.watch(productsSavedProvider);
    ref.watch(productSelectedProvider);

    Widget _buildRemoveAll() {
      return Container(
        height: 6.h,
        alignment: AlignmentDirectional.centerEnd,
        child: TextButton(
          onPressed: () {
            ref.read(savedProvider.notifier).unSavedAll();
            AppNotification().savedNotification(
              name: 'All product',
              isSaved: false,
              context: context,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.heart_broken, color: AppColors.red),
              Text('Unsaved all', style: TextStyle(color: AppColors.red)),
            ],
          ),
        ),
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
        child: _products.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                children: [
                  _buildRemoveAll(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _products.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final product = _products[index];
                      final quantity = ref
                          .watch(productSelectedProvider.notifier)
                          .getQuantity(product.id!);
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Slidable(
                          child: Stack(
                            children: [
                              _buildProduct(_products[index]),
                              Positioned(
                                right: 16,
                                bottom: 10,
                                child: ProductQuantity(quantity: quantity),
                              )
                            ],
                          ),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final isSaved = ref
                                      .read(savedProvider.notifier)
                                      .tab(_products[index]);
                                  AppNotification().savedNotification(
                                    name: product.name!,
                                    isSaved: isSaved,
                                    context: context,
                                  );
                                },
                                icon: Icons.heart_broken_rounded,
                                foregroundColor: AppColors.white,
                                backgroundColor: AppColors.red,
                                label: 'Unsaved',
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
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: AppColors.grey,
                      size: 18.h,
                    ),
                    Text(
                      'Save your favorite products.',
                      style: AppTextStyles.mediumBoldDarkGreyTextStyle,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
