import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_shop_app/model/banners_model.dart';
import 'package:online_shop_app/shared/utils/colors.dart';
import 'package:online_shop_app/shared/widgets/invalid_widget.dart';
import 'package:online_shop_app/shared/widgets/loading_widget.dart';
import 'package:online_shop_app/viewmodel/banners/banners_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerElement extends ConsumerStatefulWidget {
  const BannerElement({super.key});

  @override
  ConsumerState<BannerElement> createState() => _BannerElementState();
}

class _BannerElementState extends ConsumerState<BannerElement> {
  int _current_index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildBanners(List<BannerItems> banners) {
      return List.generate(
        banners.length,
        (index) => Container(
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
          ),
          child: SizedBox(
            width: 100.w,
            child: CachedNetworkImage(
              imageUrl: banners[index].imageUrl!,
              placeholder: (context, url) =>
                  LoadingWidget().LoadingElement(size: 8.h, lineWidth: 5),
              errorWidget: (context, url, error) =>
                  InvalidWidget().imageNotFound(height: 6.h, fontSize: 14),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }

    return ref.watch(bannersProvider).when(
          data: (banners) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 25.h,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 6),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current_index = index;
                      });
                    },
                  ),
                  items: _buildBanners(banners),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  child: AnimatedSmoothIndicator(
                    activeIndex: _current_index,
                    count: banners.length,
                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        color: AppColors.white,
                        dotBorder: DotBorder(
                          color: AppColors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        width: 1.2.h,
                        height: 1.2.h,
                      ),
                      activeDotDecoration: DotDecoration(
                        color: AppColors.orange,
                        dotBorder: DotBorder(
                          color: AppColors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        width: 5.h,
                        height: 1.2.h,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, _) => InvalidWidget().elementNotFound(
            height: 26.h,
            width: 100.w,
          ),
          loading: () => SizedBox(),
        );
  }
}
