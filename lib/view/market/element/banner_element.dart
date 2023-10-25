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
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return ref.watch(bannersViewModelProvider).when(
          data: (banners) {
            return Column(
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
                SizedBox(height: 4),
                AnimatedSmoothIndicator(
                  activeIndex: _current_index,
                  count: banners.length,
                  effect: ExpandingDotsEffect(
                    dotColor: AppColors.grey,
                    activeDotColor: AppColors.orange,
                    dotHeight: 8,
                    dotWidth: 8,
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
