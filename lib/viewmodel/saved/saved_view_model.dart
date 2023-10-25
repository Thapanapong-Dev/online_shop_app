import 'package:online_shop_app/model/products.model.dart';
import 'package:online_shop_app/viewmodel/saved/products_saved_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
part 'saved_view_model.g.dart';

@Riverpod(keepAlive: true)
class SavedViewModel extends _$SavedViewModel {
  List<String> build() {
    return [];
  }

  bool tab(ProductItems product) {
    final id = product.id!;
    if (state.contains(id)) {
      state.remove(id);
      ref.read(productsSavedViewModelProvider.notifier).remove(product);
      logger.d('$id is Unsaved');
      return false;
    } else {
      state.add(id);
      ref.read(productsSavedViewModelProvider.notifier).add(product);
      logger.d('$id is Saved');
      return true;
    }
  }

  void unSavedAll() {
    state = [];
    ref.read(productsSavedViewModelProvider.notifier).removeAll();
    logger.d('Clear product saved');
  }
}
