import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/utils.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/loading_widget.dart';
import 'package:online_shop_app/view/product/product_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductPortraitLayout extends StatelessWidget {
  const ProductPortraitLayout({
    super.key,
    required this.product,
    required this.imageSize,
    required this.margin,
    required this.nameTextStyle,
    required this.priceTextStyle,
    required this.maxLines,
    required this.loadingSize,
    required this.errorSize,
  });
  final ProductItems product;
  final double imageSize;
  final EdgeInsetsGeometry margin;
  final TextStyle nameTextStyle;
  final TextStyle priceTextStyle;
  final int maxLines;
  final double loadingSize;
  final double errorSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.PRODUCT,
        arguments: ProductArguments(product),
      ),
      child: Container(
        width: 29.w,
        padding: EdgeInsets.all(5),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 5,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: imageSize,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl!,
                placeholder: (context, url) => LoadingWidget().LoadingElement(
                  size: loadingSize,
                  lineWidth: loadingSize / 10,
                ),
                errorWidget: (context, url, error) =>
                    InvalidWidget().imageNotFound(
                  height: errorSize,
                  fontSize: errorSize / 2.5,
                ),
                fit: BoxFit.contain,
              ),
            ),
            Spacer(),
            Text(
              '${product.name}',
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: nameTextStyle,
            ),
            Spacer(),
            Text(
              '${Utils().priceFormatWithSymbol(product.price)}',
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: priceTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
