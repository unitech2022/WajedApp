import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wajed/src/core/constants/layout/app_radius.dart';
import 'package:wajed/src/core/constants/layout/palette.dart';
import 'package:wajed/src/core/constants/layout/screen_size.dart';
import 'package:wajed/src/core/routing/paths.dart';
import 'package:wajed/src/core/shared/extension/app_extensions.dart';
import 'package:wajed/src/core/shared/extension/translate_locale_key.dart';

import '../../../../../../di_container.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/shared/extension/theme_extension.dart';
import '../../../../models/home/home_model.dart';
import '../../markets/widgets/widgets.dart';

class MarketsWidget extends StatelessWidget {
  const MarketsWidget({
    Key? key,
    required this.markets,
  }) : super(key: key);

  final List<MarketsModel> markets;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: markets.length,
        (context, index) {
          return MarketCard(market: markets[index]);
        },
      ),
    );
  }
}

class MarketCard extends StatelessWidget {
  const MarketCard({
    Key? key,
    // ignore: unused_element
    this.hasDivider = false,
    required this.market,
    this.isClickable = true,
  }) : super(key: key);

  final bool hasDivider;
  final MarketsModel? market;
  final bool isClickable;
  @override
  Widget build(BuildContext context) {
    log("Market - Data ${market?.title} data:: $market##");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: !isClickable
              ? null
              : () {
                  appRoute.push(ClientPath.marketDetails, extra: market!);
                  log("Market data:: $market ##");
                },
          splashColor: Palette.restaurantColor.withOpacity(0.1),
          child: Container(
            // height: AppSize.s200,
            // color: Colors.red.shade200,
            margin: EdgeInsets.symmetric(
              horizontal: context.getHorizontalPadding(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Container(
                  width: context.getHomeCardSize(),
                  height: context.getHomeCardSize(),
                  padding: const EdgeInsets.all(AppSize.s2),
                  margin: const EdgeInsets.symmetric(vertical: AppSize.s5),
                  decoration: const BoxDecoration(
                    color: Palette.white,
                    borderRadius: AppRadius.r10,
                    boxShadow: [
                      BoxShadow(
                        color: Palette.kShadowColor,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.r10,
                    child: CachedNetworkImage(
                      imageUrl: context.getImageURL(market!.imageUrl),
                      errorWidget: (context, url, error) {
                        return ProductImgErrorWidget();
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Store details
                Expanded(
                  child: Container(
                    // height: getHomeCardSize(context),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s10,
                      // vertical: AppSize.s5,
                    ),
                    decoration: const BoxDecoration(
                      // color: Colors.blueGrey,
                      borderRadius: AppRadius.r10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(market!.title),
                            RatingBar(
                              minRating: 1,
                              maxRating: 5,
                              initialRating: market!.rate.toDouble(),
                              itemSize: AppSize.s16,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: const Icon(Icons.star),
                                empty: const Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                              ),
                              onRatingUpdate: (val) {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                market!.desc,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Palette.kDarkGrey,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            /// km & store status
                            Row(
                              children: [
                                Container(
                                  // width: AppSize.s50,
                                  height: AppSize.s20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSize.s10,
                                    // vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFB7B7B7),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(AppSize.s8),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      market!.distance.toString(),
                                      style: context.bodyS,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSize.s5),
                                Container(
                                  width: AppSize.s70,
                                  // height: AppSize.s20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSize.s5,
                                    // vertical: 3,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Palette.kStoreClosedColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.s10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      // "مغلق",
                                      market!.status == 0
                                          ? context.translate("closed")
                                          : context.translate("open"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Palette.white,
                                            height: 1.5,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // End
                          ],
                        ),

                        /// Delivery Time, Delivery fee and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                // "توصيل خلال 60 د",
                                market!.title.toString(),
                                // overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "توصيل مجاني",
                                style: context.bodyS,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "الحد الادني 60 رس",
                                style: context.bodyS,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasDivider)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getHorizontalPadding(),
            ),
            child: const Divider(
              color: Palette.kDividerColor,
              // thickness: 20,
            ),
          ),
      ],
    );
  }
}
