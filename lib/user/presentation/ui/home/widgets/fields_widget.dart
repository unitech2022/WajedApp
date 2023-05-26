import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wajed/core/extension/theme_extension.dart';


import '../../../../../core/constants/api_path.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/constants/layout/screen_size.dart';


class FieldsWidget extends StatefulWidget {
  const FieldsWidget({
    Key? key,
    required this.fields,
  }) : super(key: key);

  final List<FieldsModel>? fields;

  @override
  State<FieldsWidget> createState() => _FieldsWidgetState();
}

class _FieldsWidgetState extends State<FieldsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      // pinned: true,
      floating: true,
      delegate: _PresistentHeader(
        maxHeight: AppSize.s120,
        minHeight: AppSize.s100,
        fields: widget.fields!,
      ),
    );
  }
}

class _PresistentHeader extends SliverPersistentHeaderDelegate {
  _PresistentHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.fields,
  });
  final double maxHeight;
  final double minHeight;
  final List<FieldsModel> fields;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Palette.white,
      alignment: Alignment.center,
      child: SizedBox(
        // height: AppSize.s90,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: context.getHorizontalPadding(),
            vertical: AppSize.s10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) {
                return FieldCard(
                  title: fields[index].name,
                  fieldId: fields[index].id,
                  logo: CachedNetworkImage(
                    imageUrl: Endpoints.baseURLImages + fields[index].imageUrl!,
                    errorWidget: (context, url, error) {
                      return const ProductImgErrorWidget();
                    },
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => maxHeight;
  // double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class FieldCard extends StatelessWidget {
  const FieldCard({
    Key? key,
    required this.logo,
    required this.title,
    required this.fieldId,
  }) : super(key: key);

  final Widget logo;
  final String title;
  final int fieldId;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(AppSize.s14));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s5),
      child: Material(
        shadowColor: Palette.kBlackColor.withOpacity(0.5),
        borderRadius: borderRadius,
        color: Palette.white,
        elevation: AppSize.s7,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            final Map<String, dynamic> data = {
              "marketTitle": title,
              "fieldId": fieldId,
            };
            appRoute.push(ClientPath.viewMarkets, extra: data);
            log("I am pressed!@!");
          },
          child: SizedBox(
            width: context.wSize * 0.27,
            // height: AppSize.s90,
            // margin: const EdgeInsets.symmetric(horizontal: AppSize.s5),
            // decoration: const BoxDecoration(
            // color: Palette.white,
            // borderRadius: AppRadius.r10,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 6,
            //     offset: Offset(1.0, 3.0),
            //   ),
            // ],
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: AppSize.s40,
                  height: AppSize.s40,
                  child: logo,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s2),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleS.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.kDarkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
