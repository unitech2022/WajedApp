import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class ChooseLoginRegisterScreen extends StatelessWidget {
  const ChooseLoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getHorizontalPadding(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: AppSize.s200,
                // color: Colors.black26,
                child: SvgPicture.asset(AppAssets.logoWhite),
              ),
              const SizedBox(height: AppSize.s14),
              CustomSlideAnimation(
                isRight: true,
                child: CustomButton(
                  onPressed: () {
                    // appRoute.push(ClientPath.loginWithPhone, extra: false);
                    // appRoute.push(GlobalPath.chooseUserType);
                    pushPageRoutName(context, ClientPath.loginWithPhone);
                  },
                  title: LocaleKeys.login.tr(),
                  titleColor: Palette.restaurantColor,
                  backgroundColor: Palette.white,
                ),
              ),
              const SizedBox(height: AppSize.s14),
              CustomSlideAnimation(
                isRight: false,
                child: CustomButton(
                  onPressed: () {
                    // appRoute.push(ClientPath.loginWithPhone, extra: true);
                   
                    pushPageRoutName(context, GlobalPath.chooseUserType);
                  },
                  title: LocaleKeys.newAccount.tr(),
                  borderSide: const BorderSide(
                    color: Palette.white,
                    width: AppSize.s1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
