// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// import '../../common_widgets/custom_button.dart';

// import '../../constants/layout/app_assets.dart';

// import 'package:wajed/src/core/constants/layout/app_radius.dart';

// import '../../constants/layout/app_sizes.dart';

// import 'package:wajed/src/core/constants/layout/palette.dart';
// import 'package:wajed/src/core/constants/layout/screen_size.dart';

// import '../../shared/dimentions.dart';

// import '../../utils/app_utils.dart';

// class LocationOnMapScreen extends StatefulWidget {
//   const LocationOnMapScreen({super.key});

//   @override
//   State<LocationOnMapScreen> createState() => _LocationOnMapScreenState();
// }

// class _LocationOnMapScreenState extends State<LocationOnMapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();

//   Location location = Location();
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//   late Future<LocationData>? futureLocation;

//   LatLng? _currentLatLng;
//   List<geocoding.Placemark>? _places;

//   getAddress() async {
//     if (_currentLatLng != null) {
//       _places = await geocoding.placemarkFromCoordinates(
//         _currentLatLng!.latitude,
//         _currentLatLng!.longitude,
//       );
//     }
//   }

//   initLocation() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     futureLocation = location.getLocation().then((value) {
//       _currentLatLng = LatLng(value.latitude!, value.longitude!);
//       setState(() {});
//       return value;
//     });
//   }

//   bool isMapVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("حدد العنوان على الخريطة"),
//       ),
//       body: SafeArea(
//         top: false,
//         // bottom: false,
//         child: FutureBuilder<LocationData>(
//           future: futureLocation,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done &&
//                 snapshot.hasData) {
//               return Stack(
//                 children: [
//                   AnimatedOpacity(
//                     curve: Curves.fastOutSlowIn,
//                     opacity: isMapVisible == true ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 600),
//                     child: GoogleMap(
//                       myLocationButtonEnabled: false,
//                       zoomControlsEnabled: false,
//                       myLocationEnabled: true,
//                       initialCameraPosition: CameraPosition(
//                         zoom: 17.0,
//                         target: LatLng(
//                           snapshot.data!.latitude!,
//                           snapshot.data!.longitude!,
//                         ),
//                       ),
//                       onCameraMove: (position) {
//                         _currentLatLng = position.target;
//                         getAddress();
//                       },
//                       onMapCreated: (GoogleMapController controller) {
//                         _controller.complete(controller);
//                         Future.delayed(
//                           const Duration(milliseconds: 550),
//                           () {
//                             setState(
//                               () {
//                                 isMapVisible = true;
//                               },
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     top: 0,
//                     right: 0,
//                     bottom: AppSize.s30,
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: SvgPicture.asset(
//                         AppAssets.marker,
//                         width: AppSize.s50,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: AppSize.s1,
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             Container(
//                               alignment: Alignment.center,
//                               width: context.wSize * 0.90,
//                               decoration: const BoxDecoration(
//                                 color: Colors.green,
//                               ),
//                             ),
//                             Positioned(
//                               child: FloatingActionButton(
//                                 backgroundColor: Palette.white,
//                                 onPressed: () {
//                                   _controller.future.whenComplete(
//                                     () async {
//                                       final GoogleMapController controller =
//                                           await _controller.future;
//                                       controller.animateCamera(
//                                         CameraUpdate.newCameraPosition(
//                                           CameraPosition(
//                                             zoom: 17.0,
//                                             target: LatLng(
//                                               snapshot.data!.latitude!,
//                                               snapshot.data!.longitude!,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                       setState(() {});
//                                     },
//                                   );
//                                 },
//                                 child: const Icon(
//                                   Icons.my_location,
//                                   color: Palette.restaurantColor,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: AppSize.s10),
//                         Container(
//                           width: context.wSize,
//                           height: AppSize.s120,
//                           padding: const EdgeInsets.all(AppSize.s10),
//                           margin: EdgeInsets.symmetric(
//                             horizontal: context.getHorizontalPadding(),
//                           ),
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: AppRadius.r10,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: AppSize.s10,
//                               )
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   _places?[0].street ?? "",
//                                   maxLines: 2,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                         overflow: TextOverflow.ellipsis,
//                                         color: Palette.kDarkGrey,
//                                       ),
//                                 ),
//                               ),
//                               Text(
//                                 "Exit، طريق الامام سعود بن عبدالعزيز بن محمد الفرعي، المغرزات، الرياض 12483",
//                                 maxLines: 2,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle1!
//                                     .copyWith(
//                                       color: Palette.kGreyColor,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: bottomBtnPadding(),
//                           child: CustomButton(
//                             title: "اختيار",
//                             onPressed: () {},
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
