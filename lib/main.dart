import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajed/common/presentation/cubit/app_cubit/app_cubit.dart';
import 'package:wajed/common/presentation/ui/auth/login/login_screen.dart';
import 'package:wajed/common/presentation/ui/auth/reigister/registration_screen.dart';
import 'package:wajed/common/presentation/ui/change_language/choose_language_screen.dart';
import 'package:wajed/common/presentation/ui/splash/splash_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:wajed/core/routing/paths.dart';

import 'common/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'common/presentation/ui/auth/choose_login_register_screen.dart';
import 'common/presentation/ui/auth/choose_user_type_screen.dart';
import 'core/constants/layout/app_fonts.dart';
import 'core/constants/layout/app_sizes.dart';
import 'core/constants/layout/palette.dart';
import 'core/helpers/helper_functions.dart';
import 'core/router/routes.dart';
import 'core/services/services_locator.dart';

void main() async {
  ServicesLocator().init();
  // WidgetsBinding widgetsBinding = 
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await readToken();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/i18n",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: Phoenix(child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (BuildContext context) => sl<AuthCubit>()),
        BlocProvider<AppCubit>(
            create: (BuildContext context) => sl<AppCubit>()),
      ],
      child: MaterialApp(
          title: "wajed",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          initialRoute: splash,
          routes: {
            splash: (context) => const SplashScreen(),
            selectLang: (context) => const ChooseLanguageScreen(),
            GlobalPath.chooseLoginRegister: (context) =>
                const ChooseLoginRegisterScreen(),
            ClientPath.loginWithPhone: (context) =>
                const LoginWithPhoneScreen(),
            GlobalPath.chooseUserType: (context) =>
                const ChooseUserTypeScreen(),
        // ClientPath.home :(context) => ClientHomeScreen(addressId: addressId);,
          }),
    );
  }
}

ThemeData lightTheme(BuildContext context) {
  // final currentLang = prefs.getString(AppConstants.langugageCode);
  return ThemeData(
    // useMaterial3: true,
    scaffoldBackgroundColor: Palette.white,
    // primaryColor: Palette.restaurantColor,
    splashFactory: InkRipple.splashFactory,
    fontFamily: AppFonts.stc,
    // currentLang == AppConstants.ar ? AppFonts.stc : AppFonts.montserrat,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Palette.mainColor,
        ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Palette.mainColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.white,
      elevation: AppSize.s5,
      shadowColor: Color(0x9AF1F1F1),
      iconTheme: IconThemeData(
        color: Palette.kDarkGrey,
      ),
      titleTextStyle: TextStyle(
        color: Palette.kDarkGrey,
        fontFamily: AppFonts.stc,
        fontSize: AppSize.s20,
      ),
    ),
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Palette.restaurantColor,
    // ),
  );
}
