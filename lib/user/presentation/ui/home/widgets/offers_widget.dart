import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wajed/src/core/constants/api_path.dart';
import 'package:wajed/src/core/constants/layout/app_radius.dart';
import 'package:wajed/src/core/constants/layout/palette.dart';
import 'package:wajed/src/core/constants/layout/screen_size.dart';

import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../models/home/home_model.dart';

class OffersSliderWidget extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();
  final List<OffersModel> offers;
  OffersSliderWidget({
    Key? key,
    required this.offers,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log("offers.length:: ${offers.length} ##");
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: AppSize.s150,
          child: CarouselSlider(
            carouselController: _carouselController,
            items: List.generate(
              offers.length,
              (index) {
                final imageUrl =
                    Endpoints.baseURLImages + (offers[index].image ?? "");
                return Container(
                  width: context.wSize,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Palette.kGreyLightColor,
                    borderRadius: AppRadius.r10,
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.r10,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            options: CarouselOptions(
              autoPlay: true,
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.9,
            ),
          ),
        ),
      ),
    );
  }
}
