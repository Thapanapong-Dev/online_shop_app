import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:online_shop_app/routers.dart';
import 'package:online_shop_app/shared/utils/theme.dart';
import 'package:online_shop_app/view/checkout/checkout_view.dart';
import 'package:online_shop_app/view/payment/payment_view.dart';
import 'package:online_shop_app/view/home/home_view.dart';
import 'package:online_shop_app/view/product/product_view.dart';
import 'package:online_shop_app/view/recommend/recommend_view.dart';
import 'package:online_shop_app/view/checkout/widget/tax_invoice_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: ResponsiveSizer(
        builder: (context, orientation, screenTyp) {
          return MaterialApp(
            builder: (context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: 1),
                child: child!,
              );
            },
            title: 'Flutter Demo',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.INITIAL,
            routes: {
              Routes.INITIAL: (context) => const HomeView(),
              Routes.RECOMMEND: (context) => const RecommendView(),
              Routes.PRODUCT: (context) => ProductView(),
              Routes.PAYMENT: (context) => PaymentView(),
              Routes.CHECKOUT: (context) => CheckoutView(),
              Routes.TAX_INVOICE: (context) => TaxInvoiceView(),
            },
          );
        },
      ),
    );
  }
}
