import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/view/cart/cart_view.dart';
import 'package:online_shop_app/view/market/market_view.dart';
import 'package:online_shop_app/view/saved/saved_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  final List<Widget> _pageName = <Widget>[
    const Text('Market'),
    const Text('Saved'),
    const Text('Cart'),
  ];

  final List<Widget> _homePage = <Widget>[
    const MarketView(),
    const SavedView(),
    const CartView(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pageName.elementAt(_selectedIndex),
        automaticallyImplyLeading: false,
      ),
      body: _homePage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
        selectedLabelStyle: AppTextStyles.normalTextStyle,
        unselectedLabelStyle: AppTextStyles.normalTextStyle,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.darkGrey,
        selectedIconTheme: const IconThemeData(size: 26, color: Colors.orange),
        unselectedIconTheme: const IconThemeData(color: AppColors.darkGrey),
        backgroundColor: AppColors.white,
      ),
    );
  }
}
