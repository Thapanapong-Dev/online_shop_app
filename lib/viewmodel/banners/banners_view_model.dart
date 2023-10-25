import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:online_shop_app/model/banners_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'banners_view_model.g.dart';

@Riverpod(keepAlive: true)
class BannersViewModel extends _$BannersViewModel {
  FutureOr<List<BannerItems>> build() async {
    final data = json.decode(
      await rootBundle.loadString('assets/mock/banners.json'),
    ) as Map<String, Object?>;
    return BannersModel.fromJson(data).bannerItems!;
  }
}
