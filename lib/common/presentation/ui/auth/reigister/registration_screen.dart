import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:wajed/core/enums/loading_status.dart';
import 'package:wajed/core/utils/app_utils.dart';

import '../../../../../core/common_widgets/custom_button.dart';
import '../../../../../core/constants/layout/app_assets.dart';
import '../../../../../core/constants/layout/app_sizes.dart';
import '../../../../../core/constants/layout/palette.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../cubit/auth_cubit/auth_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.role});
  final String role;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _codeController,
      _phoneController,
      _fullNameController,
      _emailController,
      _refCodeController;
  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: "+566");
    _phoneController = TextEditingController();

    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _refCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      color: Palette.mainColor,
      fontWeight: FontWeight.bold,
    );
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        
      },
      builder: (context, authProvider) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: context.bottomBtnPadding(),
            child: CustomButton(
              title: "register".tr(),
              onPressed: () async {
                if (validate(context)) {
                  AuthCubit.get(context).registerUser(
                    context: context,
                    city: _refCodeController.text,
                    userName: _codeController.text.trim() +
                        _phoneController.text.trim(),
                    role: widget.role,
                    fullName: _fullNameController.text,
                    email: _emailController.text,
                  );
                }
                // log("authProvider.isLoading:: ${authProvider.isLoading} ##");

                // if (authProvider.isLoading) {
                //   circularDialog(context);
                // } else {
                //   // context.pop();
                // }
                // final RegisterUserModel userModel = RegisterUserModel(
                //   userName: _phoneController.text.trim(),
                //   fullName: _fullNameController.text,
                //   email: _emailController.text,
                //   password: "",
                //   role: "user",
                //   city: "",
                // );
                // context.read<AuthCubit>().registration(userModel);
              },
            ),
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.only(bottom: AppSize.s20),
                  decoration: const BoxDecoration(
                    color: Palette.mainColor,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      AppAssets.logoWhite,
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    child: SingleChildScrollView(
                      padding: listViewPadding(context),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  decoration: InputDecoration(
                                    label: Text(
                                      'country_code'.tr(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  // readOnly: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    // LengthLimitingTextInputFormatter(9),
                                    // CustomNumberFormater(),
                                  ],
                                  decoration: InputDecoration(
                                    label: Text(
                                      "mobile_number".tr(),
                                      style: textStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _fullNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              label: Text(
                                "your_name".tr(),
                                style: textStyle,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: Text(
                                "your_email".tr(),
                                style: textStyle,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _refCodeController,
                            decoration: InputDecoration(
                              label: Text(
                                "city".tr(),
                                style: textStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  onChanged: (val) {},
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  checkColor: Palette.white,
                                  fillColor: MaterialStateProperty.all(
                                    Palette.mainColor,
                                  ),
                                  value: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3)),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "registration_terms".tr(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validate(BuildContext context) {
    if (_phoneController.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "من فضلك اكتب  رقم الهاتف",
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_fullNameController.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "من فضلك اكتب الاسم كاملا",
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_emailController.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "من فضلك اكتب  الايميل",
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_refCodeController.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "من فضلك اكتب اسم القرية ",
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}
