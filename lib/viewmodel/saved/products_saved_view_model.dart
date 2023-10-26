import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_saved_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductsSaved extends _$ProductsSaved {
  List<ProductItems> build() {
    return [];
  }

  void add(ProductItems product) {
    state = [...state, product];
    logger.d('${product.id} add products to saved.');
  }

  void remove(ProductItems product) {
    state = [
      for (final productSaved in state)
        if (productSaved != product) productSaved,
    ];
    logger.d('${product.id} remove products in saved.');
  }

  void removeAll() {
    state = [];
    logger.d('Clear all product saved.');
  }
}
