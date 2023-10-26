import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/viewmodel/saved/products_saved_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
part 'saved_view_model.g.dart';

@Riverpod(keepAlive: true)
class Saved extends _$Saved {
  List<String> build() {
    return [];
  }

  void save(String id) {
    state = [...state, id];
    logger.d('$id is Saved.');
  }

  void unsave(String id) {
    state = [
      for (final idSaved in state)
        if (idSaved != id) idSaved,
    ];
    logger.d('$id is Unsaved.');
  }

  void unSavedAll() {
    state = [];
    ref.read(productsSavedProvider.notifier).removeAll();
    logger.d('Clear saved.');
  }

  bool tab(ProductItems product) {
    if (state.contains(product.id!)) {
      ref.read(savedProvider.notifier).unsave(product.id!);
      ref.read(productsSavedProvider.notifier).remove(product);
      return false;
    } else {
      ref.read(savedProvider.notifier).save(product.id!);
      ref.read(productsSavedProvider.notifier).add(product);
      return true;
    }
  }
}
