import 'package:flutter/material.dart';
import 'package:wajed_app/core/extension/theme_extension.dart';


import '../common_widgets/circular_progress.dart';
import '../common_widgets/custom_button.dart';
import '../constants/layout/app_sizes.dart';
import '../constants/layout/palette.dart';

Future<void> showUpdatesLoading(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return Future.value(true);
        },
        child: Center(
          child: Container(
            width: AppSize.s90,
            height: AppSize.s90,
            decoration: const BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.s10),
              ),
            ),
            child: const Center(
              child: SizedBox(
                width: AppSize.s28,
                height: AppSize.s28,
                child: CustomCircularProgress(),
              ),
            ),
          ),
        ),
      );
    },
  );
}

showErrorLoading(BuildContext context, String error) async {
  return showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return Future.value(true);
        },
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.s14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    // width: AppSize.s90,
                    constraints: const BoxConstraints(
                      minHeight: AppSize.s100,
                    ),
                    decoration: const BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.s10),
                      ),
                    ),
                    child: Text(
                      error,
                      style: context.titleL,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                CustomButton(
                  title: "حسنا",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
