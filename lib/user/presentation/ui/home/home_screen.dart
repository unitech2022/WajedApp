import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wajed/common/models/user_response.dart';
import 'package:wajed/core/constants/layout/screen_size.dart';
import 'package:wajed/core/extension/theme_extension.dart';



import '../../../../core/common_widgets/circular_progress.dart';
import '../../../../core/common_widgets/home/home_search_bar.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/layout/app_assets.dart';
import '../../../../core/constants/layout/app_sizes.dart';

import '../../../../core/constants/layout/palette.dart';
import '../../../../core/utils/app_utils.dart';


import 'widgets/fields_widget.dart';
import 'widgets/markets_widget.dart';

@immutable
class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({
    super.key,
    required this.addressId,
  });
  final int? addressId;

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        // context.read<HomeCubit>().getUserHome(widget.addressId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // HiveServiceImp().getUser();
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: Palette.transparent,
    //     systemNavigationBarColor: Palette.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    log("## Build again - Home Screen ##");
    return _HomeWidget();
  }
}

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.wSize / 2.5,
              height: context.hSize / 2.5,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.wifi_off,
                  color: Colors.pink.shade700,
                  size: context.wSize / 5,
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            const Center(
              child: Text("لا يوجد إتصال بالإنترنت"),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            Center(
              child: MaterialButton(
                color: Palette.kOrangeColor,
                onPressed: onTap,
                child: const Text("حاول مرة أخرى"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomDrawer extends StatelessWidget {
  const _CustomDrawer({
    required this.user,
  });

  final User? user;
  @override
  Widget build(BuildContext context) {
    // final currentLang = prefs.getString(AppConstants.langugageCode);
    // log("From drawer - client:: $currentLang");

    return Drawer(
      backgroundColor: Palette.mainColor,
      child: SafeArea(
        // top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: listViewPadding(context),
                child: Column(
                  children: [
                    const SizedBox(height: AppSize.s14),
                    const _DrawerArrowBackWidget(),
                    const SizedBox(height: AppSize.s10),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: AppSize.s33,
                          backgroundColor: Palette.white,
                          child: CachedNetworkImage(
                            imageUrl: user?.profileImage ?? "",
                            errorWidget: (context, url, error) {
                              return Center(
                                child: Text(
                                  user?.fullName!.substring(0, 1) ?? "",
                                  style: context.headlineS.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: AppSize.s20),
                        Expanded(
                          child: SizedBox(
                            height: AppSize.s60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    user?.fullName ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Palette.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                ),
                                Text(
                                  user?.userName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Palette.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s10),
                    Divider(
                      color: Palette.white.withOpacity(0.5),
                    ),
                    _CustomListTile(
                      title:"my_orders".tr(),
                      icon: AppAssets.myOrders,
                      onPressed: () {
                        // log("user id:: ${user!.id}");
                        // appRoute.push('/previousOrders');
                      },
                    ),
                    _CustomListTile(
                      title: "notifications".tr(),
                      icon: AppAssets.notifications,
                      onPressed: () {
                        // appRoute.push(ClientPath.notifications);
                      },
                    ),
                    _CustomListTile(
                      title:"usage_policy".tr(),
                      icon: AppAssets.terms,
                      onPressed: () {
                        // appRoute.push(ClientPath.usagePolicy);
                      },
                    ),
                    _CustomListTile(
                      title: "settings".tr(),
                      icon: AppAssets.settings,
                      onPressed: () {
                        // appRoute.push('/userSettings');
                      },
                    ),
                    _CustomListTile(
                      title: "contact_us".tr(),
                      icon: AppAssets.chat,
                      onPressed: () {
                        // appRoute.push('/customerService');
                      },
                    ),
                    // BlocConsumer<LocalizationCubit, LocalizationViewModelState>(
                    //   listener: (context, state) {},
                    //   builder: ((context, value) {
                    //     return const SizedBox();
                    //     // return _CustomListTile(
                    //     //   title: currentLang == AppConstants.ar ||
                    //     //           value.locale == const Locale(AppConstants.ar)
                    //     //       ? "English"
                    //     //       : "العربية",
                    //     //   icon: AppAssets.language,
                    //     //   onPressed: () {
                    //     //     log("currentLang:: $currentLang");
                    //     //     if (currentLang == "ar" ||
                    //     //         value.locale == const Locale(AppConstants.ar)) {
                    //     //       context.read<LocalizationViewModel>().setLanguage(
                    //     //             const Locale(AppConstants.en),
                    //     //           );
                    //     //     } else {
                    //     //       context.read<LocalizationViewModel>().setLanguage(
                    //     //             const Locale(AppConstants.ar),
                    //     //           );
                    //     //     }
                    //     //     appRoute.go(GlobalPath.splash);
                    //     //   },
                    //     // );
                    //   }),
                    // ),
                 
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getHorizontalPadding(),
              ),
              child: Column(
                children: [
                  const Divider(color: Palette.white),
                  // Exit
                  ListTile(
                    onTap: () {
                      // context.read<AuthCubit>().logout();

                      // appRoute.go(GlobalPath.splash, extra: false);
                    },
                    title: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.logout,
                          width: AppSize.s20,
                        ),
                        const SizedBox(width: AppSize.s10),
                        Text(
                          "logout".tr(),
                          style: context.titleM.copyWith(
                            color: Palette.white,
                          ),
                        ),
                      ],
                    ),
                    // trailing:
                    //     BlocConsumer<AppConfigCubit, AppConfigViewModelState>(
                    //   listener: (context, state) {},
                    //   builder: (context, provider) {
                    //     return Text(
                    //       // "Version: ${provider.appVersion}",
                    //       "Version: ",
                    //       style: context.titleS.copyWith(
                    //         color: Palette.white,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String icon;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.r10,
      ),
      textColor: Palette.white,
      leading: SvgPicture.asset(
        icon,
      ),
      title: Text(title),
      onTap: onPressed,
    );
  }
}

class _DrawerArrowBackWidget extends StatelessWidget {
  const _DrawerArrowBackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_forward,
          color: Palette.white,
        ),
      ),
    );
  }
}

class _PinnedSearchBar extends StatelessWidget {
  const _PinnedSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      primary: false,
      bottom: HomeSearchBar(),
      backgroundColor: Palette.white,
      elevation: 3.0,
    );
  }
}

class _PinnedSliverAppBar extends StatelessWidget {
  const _PinnedSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {},
        child: Center(
          child: Container(
            // width: AppSize.s44,
            // height: AppSize.s44,
            margin: const EdgeInsets.all(AppSize.s5),
            decoration: const BoxDecoration(
              // color: Palette.restaurantColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.s10),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.menuSvg,
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Row(
        children: [
          Text(
            context.translate(LocaleKeys.deliveryTo),
            style: context.titleM.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(width: AppSize.s5),
          Container(
            height: AppSize.s35,
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            decoration: const BoxDecoration(
              color: Palette.restaurantColor,
              borderRadius: AppRadius.r10,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Palette.white,
                focusColor: Palette.restaurantColor,
                borderRadius: AppRadius.r10,
                isDense: true,
                icon: const Icon(
                  CupertinoIcons.forward,
                  size: AppSize.s20,
                  color: Palette.white,
                ),
                onChanged: (val) {},
                hint: Text(
                  "Address #1",
                  style: context.titleS.copyWith(
                    color: Palette.white,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "AddressOne",
                    child: Text("Address 1"),
                  ),
                  DropdownMenuItem(
                    value: "AddressTwo",
                    child: Text("Address 2"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        const SizedBox(width: AppSize.s10),
        IconButton(
          onPressed: () {},
          splashRadius: AppSize.s28,
          icon: SvgPicture.asset(
            AppAssets.shoppingCart,
            height: AppSize.s30,
          ),
        ),
      ],
      backgroundColor: Palette.white,
    );
  }
}

class _HomeWidget extends StatefulWidget {
  @override
  State<_HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<_HomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<String>? savedAddressFuture;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      savedAddressFuture =
          context.read<AddressesHistoryCubit>().getSavedAddress();
      context.read<AuthCubit>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeViewModelState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const CustomHomeShimmerScreen();
          },
          loaded: (homeModel) {
            final user = context.read<AuthCubit>().getUserData();
            return Scaffold(
              key: _scaffoldKey,
              drawer: _CustomDrawer(user: user),
              // drawer: BlocSelector<AuthCubit, AuthViewModelState, LoginSession>(
              //   selector: (state) {
              //     return state.maybeWhen(
              //       orElse: () => ,
              //       getUserData: (LoginSession value) {
              //         return value.loginSession!;
              //       },
              //     );
              //   },
              //   builder: (context, user) {
              //     return _CustomDrawer(user: user);
              //   },
              // ),
              body: NestedScrollView(
                floatHeaderSlivers: true,
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Palette.white,
                      pinned: true,
                      elevation: AppSize.zero,
                      leading: GestureDetector(
                        onTap: () {
                          if (_scaffoldKey.currentState != null) {
                            _scaffoldKey.currentState!.openDrawer();
                          }
                        },
                        child: Center(
                          child: Container(
                            // width: AppSize.s44,
                            // height: AppSize.s44,
                            margin: const EdgeInsetsDirectional.only(
                                start: AppSize.s20),
                            decoration: const BoxDecoration(
                              // color: Palette.restaurantColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(AppSize.s10),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.menuSvg,
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Center(
                          child: Text(
                            context.translate(LocaleKeys.deliveryTo),
                            // style: AppBarTheme.of(context).titleTextStyle,
                            style: context.titleM.copyWith(
                              color: Palette.kBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s10),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              appRoute.push("/userAddresses");
                            },
                            child: Container(
                              height: AppSize.s35,
                              constraints:
                                  const BoxConstraints(minWidth: AppSize.s100),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSize.s8,
                              ),
                              decoration: const BoxDecoration(
                                color: Palette.mainColor,
                                borderRadius: AppRadius.r10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(homeModel.address?.name ?? ""),
                                  FutureBuilder<String>(
                                    future: context
                                        .read<AddressesHistoryCubit>()
                                        .getSavedAddress(),
                                    builder: ((context, snapshot) {
                                      return snapshot.hasData
                                          ? Text(snapshot.data.toString())
                                          : const CustomCircularProgress(
                                              size: Size(
                                                  AppSize.s14, AppSize.s14),
                                              strokeWidth: AppSize.s2,
                                            );
                                      // : Text(context.translate("address"));
                                    }),
                                  ),
                                  const Icon(
                                    CupertinoIcons.forward,
                                    size: AppSize.s20,
                                    color: Palette.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSize.s20),
                      ],
                    ),
                    if (homeModel.fields.isNotEmpty)
                      FieldsWidget(fields: homeModel.fields),
                    const _PinnedSearchBar(),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<HomeCubit>().refresh();
                  },
                  child: SafeArea(
                    top: false,
                    child: CustomScrollView(
                      slivers: [
                        if (homeModel.categories != null)
                          OffersSliderWidget(
                            offers: homeModel.offers,
                          ),
                        if (homeModel.markets != null)
                          MarketsWidget(
                            markets: homeModel.markets,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (message) {
            return ErrorScreen(
              message: message,
            );
          },
          orElse: () {
            return const Scaffold();
          },
        );
      },
    );
  }
}
