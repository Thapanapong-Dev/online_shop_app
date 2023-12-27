import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/utils/constants.dart';
import 'package:online_shop_app/shared/utils/text_styles.dart';
import 'package:online_shop_app/viewmodel/checkout/tax_invoice_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaxInvoiceView extends ConsumerStatefulWidget {
  TaxInvoiceView({Key? key}) : super(key: key);

  @override
  _TaxInvoiceViewState createState() => _TaxInvoiceViewState();
}

class _TaxInvoiceViewState extends ConsumerState<TaxInvoiceView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  Widget _buildTaxInvoiceBtn(TaxInvoiceType type) {
    String title =
        type == TaxInvoiceType.nonjuristic ? 'Non juristic' : 'Juristic';
    return ElevatedButton(
      child: Text(title),
      onPressed: () {
        if (ref.read(currentIndexProvider) != tabController.index)
          tabController.animateTo(tabController.index == 0 ? 1 : 0);
        ref.read(currentIndexProvider.notifier).state = tabController.index;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        shadowColor: AppColors.grey,
        elevation: 0.5,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: AppTextStyles.mediumBoldTextStyle,
      ),
    );
  }

  Widget _buildTaxInvoiceType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: _buildTaxInvoiceBtn(TaxInvoiceType.nonjuristic),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _buildTaxInvoiceBtn(TaxInvoiceType.juristic),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tax Invoice'),
        elevation: 0,
        toolbarHeight: 5.h,
      ),
      body: DefaultTabController(
          animationDuration: Duration.zero,
          length: 2,
          child: Column(
            children: [
              _buildTaxInvoiceType(),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Text('data 1'),
                    ),
                    Card(
                      margin: const EdgeInsets.all(16.0),
                      child: Text('data 2'),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
