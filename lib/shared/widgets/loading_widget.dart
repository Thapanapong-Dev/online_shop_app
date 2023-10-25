import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_shop_app/shared/utils/colors.dart';

class LoadingWidget {
  Widget LoadingElement({required double size, required double lineWidth}) {
    return SpinKitRing(
      color: AppColors.orange,
      lineWidth: lineWidth,
      size: size,
    );
  }
}
