import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/viewmodel/cart/products_cart_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:online_shop_app/model/product_selected.dart';
part 'product_selected_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProductSelected extends _$ProductSelected {
  ProductsSelected build() {
    return ProductsSelected(
      products: [],
      totaPrice: 0,
    );
  }

  void add(Products product) {
    state = ProductsSelected(
      products: [...state.products!, product],
      totaPrice: state.totaPrice,
    );
    logger.d('${product.id} selected product.');
  }

  void remove(Products product) {
    state = ProductsSelected(
      products: [
        for (final productsSelected in state.products!)
          if (productsSelected != product) productsSelected,
      ],
      totaPrice: state.totaPrice,
    );
    ref.read(productSelectedProvider.notifier).updateTotalPrice();
    logger.d('${product.id} remove product selected.');
  }

  void removeAll() {
    state = ProductsSelected(
      products: [],
      totaPrice: 0,
    );
    logger.d('Clear all product selected.');
  }

  void updateTotalPrice() {
    double totalPrice = 0;
    for (int index = 0; index < state.products!.length; index++) {
      totalPrice += state.products![index].totalByItem!;
    }
    state = ProductsSelected(
      products: state.products,
      totaPrice: totalPrice,
    );
  }

  int getQuantity(String id) {
    final product = state.products!.firstWhere(
      (element) => element.id == id,
      orElse: () => Products(),
    );
    if (product.id == null) {
      return 0;
    }
    return product.qty!;
  }

  void removeProductSelectedAndProductInCart({required ProductItems product}) {
    final _productTarget = state.products!.firstWhere(
      (element) => element.id == product.id,
      orElse: () => Products(),
    );
    if (_productTarget.id != null)
      ref.read(productSelectedProvider.notifier).remove(_productTarget);
    ref.read(productsCartProvider.notifier).remove(product);
  }

  void update({required ProductItems product, required int quantity}) {
    final current_quantity =
        ref.read(productSelectedProvider.notifier).getQuantity(product.id!);
    final _product = Products.fromJson({
      'id': product.id,
      'qty': current_quantity + quantity,
      'total_by_item':
          (product.price! * (current_quantity + quantity)).toDouble(),
      'price': product.price!.toDouble(),
      'name': product.name
    });

    if (ref.read(productsCartProvider).contains(product)) {
      final _productTarget = state.products!.firstWhere(
        (element) => element.id == product.id,
        orElse: () => Products(),
      );

      if (_productTarget.id == null) {
        ref.read(productSelectedProvider.notifier).add(_product);
      } else {
        final newProduct = state.products;
        newProduct![newProduct.indexOf(_productTarget)] = _product;
        state = ProductsSelected(
          products: newProduct,
          totaPrice: state.totaPrice,
        );
      }
      logger.d('${product.id} update(plus or minus) quantity to cart');
    } else {
      ref.read(productSelectedProvider.notifier).add(_product);
      ref.read(productsCartProvider.notifier).add(product);
    }
    ref.read(productSelectedProvider.notifier).updateTotalPrice();
  }
}
