import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wajed/core/constants/layout/screen_size.dart';
import 'package:wajed/core/extension/translate_locale_key.dart';
import 'package:wajed/core/helpers/helper_functions.dart';

import '../../../../core/common_widgets/animations/custom_slide_animation.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/locale_keys.dart';
import '../../../../core/routing/paths.dart';
import '../../cubit/app_cubit/app_cubit.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("## Build - Choose language screen ##");
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.mainColor,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.getHorizontalPadding(),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.hSize * 0.50,
                      child: SvgPicture.asset(AppAssets.logoWhite),
                    ),
                    CustomSlideAnimation(
                      isRight: true,
                      child: CustomButton(
                        onPressed: () {
                          context.setLocale(Locale('ar'));

                          AppCubit.get(context).changeLang("ar", context);
                        },
                        title: LocaleKeys.arabic.tr(),
                        titleColor: Palette.mainColor,
                        backgroundColor: Palette.white,
                      ),
                    ),
                    const SizedBox(height: AppSize.s14),
                    CustomSlideAnimation(
                      isRight: false,
                      child: CustomButton(
                        onPressed: () {
                          context.setLocale(Locale('en'));
                          AppCubit.get(context).changeLang("en", context);
                        },
                        title: LocaleKeys.english.tr(),
                        borderSide: const BorderSide(
                          color: Palette.white,
                          width: AppSize.s1,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSize.s10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
