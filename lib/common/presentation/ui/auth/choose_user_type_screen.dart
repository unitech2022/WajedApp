import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wajed/common/presentation/ui/auth/reigister/registration_screen.dart';
import 'package:wajed/core/constants/layout/screen_size.dart';
import 'package:wajed/core/extension/app_extensions.dart';
import 'package:wajed/core/extension/theme_extension.dart';
import 'package:wajed/core/extension/translate_locale_key.dart';
import 'package:wajed/core/helpers/helper_functions.dart';
import 'package:wajed/core/utils/app_utils.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/layout/app_radius.dart';
import '../../../../core/constants/layout/app_sizes.dart';
import '../../../../core/constants/layout/palette.dart';
import '../../../../core/enums/user_roles.dart';
import '../../../../core/routing/paths.dart';

class ChooseUserTypeScreen extends StatefulWidget {
  const ChooseUserTypeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseUserTypeScreen> createState() => _ChooseUserTypeScreenState();
}

class _ChooseUserTypeScreenState extends State<ChooseUserTypeScreen> {
  UserRoles userRole = UserRoles.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'إنشاء حساب جديد',
                      style: context.headlineS.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: AppSize.s100),

                    // Choose user role/type
                    ChooseUserRoleButton(
                      title: 'client_user_role'.tr(),
                      backgroundColor: Palette.kClientColor,
                      userRoles: UserRoles.client,
                      isSelected: userRole == UserRoles.client ? true : false,
                      onChanged: (val) {
                        log("Current user role1:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppSize.s14),
                    ChooseUserRoleButton(
                      title: 'restaurant_user_role'.tr(),
                      backgroundColor: Palette.kDealerColor,
                      userRoles: UserRoles.restaurant,
                      isSelected:
                          userRole == UserRoles.restaurant ? true : false,
                      onChanged: (val) {
                        log("Current user role3:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                    const SizedBox(height: AppSize.s14),
                    ChooseUserRoleButton(
                      title: 'delivery_user_role'.tr(),
                      backgroundColor: Palette.kDeliveryColor,
                      userRoles: UserRoles.delivery,
                      isSelected: userRole == UserRoles.delivery ? true : false,
                      onChanged: (val) {
                        log("Current user role2:: $val");
                        setState(() {
                          userRole = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sumit
          Padding(
            padding: context.bottomBtnPadding(),
            child: CustomButton(
              title: "confirm".tr(),
              onPressed: () {
                if (userRole == UserRoles.client) {
                  pushPage(context,  RegistrationScreen(role:userRole.name));
                
                } else if (userRole == UserRoles.restaurant) {
                  pushPage(context, RegistrationScreen(role:userRole.name));
                } else if (userRole == UserRoles.delivery) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseUserRoleButton extends StatelessWidget {
  const ChooseUserRoleButton({
    Key? key,
    this.userRoles = UserRoles.client,
    required this.title,
    required this.backgroundColor,
    required this.onChanged,
    required this.isSelected,
  }) : super(key: key);

  final UserRoles userRoles;
  final String title;
  final Color backgroundColor;
  final ValueChanged<UserRoles> onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(
        horizontal: context.getHorizontalPadding(),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: backgroundColor,
            borderRadius: AppRadius.r10,
            child: InkWell(
              borderRadius: AppRadius.r10,
              onTap: () => onChanged(userRoles),
              child: SizedBox(
                width: context.wSize,
                height: AppSize.s50,
                child: Center(
                  child: Text(
                    title,
                    style: context.titleM.copyWith(
                      color: Palette.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.directional(
            textDirection: context.direction(),
            start: AppSize.s10,
            child: Checkbox(
              // value: false,
              value: true,
              shape: const CircleBorder(),
              checkColor: isSelected ? Palette.mainColor : Colors.transparent,
              onChanged: (val) {},
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return Palette.white;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
