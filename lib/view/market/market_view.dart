import 'package:flutter/material.dart';
import 'package:online_shop_app/view/market/element/banner_element.dart';
import 'package:online_shop_app/view/market/element/recommend_element.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            BannerElement(),
            RecommendElement(),
          ],
        ),
      ),
    );
  }
}
