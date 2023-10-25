import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/viewmodel/cart/products_cart_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:online_shop_app/model/cart_model.dart';
part 'cart_view_model.g.dart';

@Riverpod(keepAlive: true)
class CartViewModel extends _$CartViewModel {
  Cart build() {
    return Cart(
      productsSelected: [],
      totaPrice: null,
    );
  }

  void removeAll() {
    state = Cart(
      productsSelected: [],
      totaPrice: null,
    );
    logger.d('Clear all product in cart');
  }

  int getProductQuantity(String id) {
    final productInCart = state.productsSelected!.firstWhere(
      (element) => element.id == id,
      orElse: () => ProductsSelected(),
    );
    if (productInCart.id == null) {
      return 0;
    }
    return productInCart.qty!;
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (int index = 0; index < state.productsSelected!.length; index++) {
      totalPrice += state.productsSelected![index].totalByItem!;
    }
    return totalPrice;
  }

  int update({
    required ProductItems product,
    required int quantity,
    bool isRemoveProductFromCart = false,
  }) {
    final id = product.id!;
    if (ref.read(productsCartViewModelProvider).contains(product)) {
      final _product = ProductsSelected.fromJson({
        'id': product.id,
        'qty': quantity,
        'total_by_item': (product.price! * quantity).toDouble(),
        'price': product.price!.toDouble(),
        'name': product.name
      });

      final _productTarget = state.productsSelected!.firstWhere(
        (element) => element.id == _product.id,
        orElse: () => ProductsSelected(),
      );

      if (quantity == 0) {
        state.productsSelected!.remove(_productTarget);
        if (isRemoveProductFromCart)
          ref.read(productsCartViewModelProvider.notifier).remove(product);
        logger.d('$id set zero quantity product');
      } else {
        if (_productTarget.id == null) {
          state.productsSelected!.add(_product);
          logger.d('$id add to cart');
        } else {
          final productInCart = state.productsSelected!.firstWhere(
            (element) => element.id == _product.id,
          );
          state.productsSelected![
              state.productsSelected!.indexOf(productInCart)] = _product;
          logger.d('$id update qty to cart');
        }
      }
      return quantity;
    } else {
      final _product = ProductsSelected.fromJson({
        'id': product.id,
        'qty': quantity,
        'total_by_item': (product.price! * quantity).toDouble(),
        'price': product.price!.toDouble(),
        'name': product.name
      });
      state.productsSelected!.add(_product);
      ref.read(productsCartViewModelProvider.notifier).add(product);
      logger.d('$id add to cart');
      return quantity;
    }
  }
}
