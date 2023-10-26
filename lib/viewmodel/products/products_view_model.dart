import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:online_shop_app/model/products.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_view_model.g.dart';

@Riverpod(keepAlive: true)
class Products extends _$Products {
  FutureOr<List<ProductItems>> build() async {
    final data = json.decode(
      await rootBundle.loadString('assets/mock/products.json'),
    ) as Map<String, Object?>;
    return ProductsModel.fromJson(data).productItems!;
  }
}
