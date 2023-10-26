import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_cart_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductsCart extends _$ProductsCart {
  List<ProductItems> build() {
    return [];
  }

  void add(ProductItems product) {
    state = [...state, product];
    logger.d('${product.id} add product to cart');
  }

  void remove(ProductItems product) {
    state = [
      for (final currentProduct in state)
        if (currentProduct != product) currentProduct,
    ];
    logger.d('${product.id} remove product in cart');
  }
}
