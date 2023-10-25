import 'package:online_shop_app/model/products.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_saved_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductsSavedViewModel extends _$ProductsSavedViewModel {
  List<ProductItems> build() {
    return [];
  }

  void add(ProductItems product) {
    state.add(product);
  }

  void remove(ProductItems product) {
    state.remove(product);
  }

  void removeAll() {
    state = [];
  }
}
