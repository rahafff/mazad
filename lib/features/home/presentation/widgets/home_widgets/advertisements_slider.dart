import 'package:carousel_slider/carousel_slider.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_advertisements_slider.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/global_states/standard_state.dart';
import '../../../domain/entities/advertisements_entity.dart';
import '../../manager/advertisement_cubit.dart';

class AdvertisementsSlider extends StatelessWidget {
  const AdvertisementsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvertisementsCubit>(
      create: (context) =>
          di.sl<AdvertisementsCubit>()..emitGetAdvertisements(),
      child: BlocBuilder<AdvertisementsCubit, StandardState<List<Sliders>>>(
          builder: (context, state) {
        return state.when(
            loading: () => const ShimmerAdvertisementsSlider(),
            success: (sliders) {
              if (sliders.isEmpty) {
                return const SizedBox.shrink();
              }
              return CarouselSlider.builder(
                itemBuilder: (context, index, realIndex) {
                  final slider = sliders[index];
                  return GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse(slider.sliderLink!),
                      );
                    },
                    child: Container(
                      height: 18.0.h,
                      width: 90.0.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0.w),
                        image: DecorationImage(
                            image: ExtendedNetworkImageProvider(
                              EndPoints.baseUrl + slider.sliderMobileImage!,
                            ),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 15.0.h,
                  aspectRatio: 9 / 16,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                itemCount: sliders.length,
              );
            },
            error: (error) => const SizedBox.shrink());
      }),
    );
  }
}
