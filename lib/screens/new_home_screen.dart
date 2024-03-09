// import 'package:flutter/material.dart';
// import 'package:vpn_basic_project/screens/custom_clipper.dart';
// import 'package:vpn_basic_project/screens/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vpn_basic_project/main.dart';
// import 'package:vpn_basic_project/screens/location_screen.dart';
// import 'package:vpn_basic_project/screens/network_test_screen.dart';
// import '../controllers/home_controller.dart';
// import '../models/vpn_status.dart';
// import '../screens/utils.dart';
// import '../services/vpn_engine.dart';
// import '../widgets/count_down_timer.dart';
// import 'custom_clipper.dart';
// import '../widgets/home_card.dart';

// void main() => runApp(MyApp());
// HomeController _controller = HomeController();

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nucleus VPN',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NewHomeScreen(),
//     );
//   }
// }

// class NewHomeScreen extends StatefulWidget {
//   NewHomeScreen({Key? key}) : super(key: key);
//   @override
//   _NewHomeScreenState createState() => _NewHomeScreenState();
// }

// class _NewHomeScreenState extends State<NewHomeScreen> {
//   late HomeController _controller;

//   @override
//   void initState() {
//     // Initialize the _controller using Get.put in the initState
//     _controller = Get.put(HomeController());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final _controller = Get.find<HomeController>();

//     final _controller = Get.put(HomeController());
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: bgColor,
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: _changeLocation(context),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               upperCurvedContainer(context),

//               Obx(() => _vpnButton(context)),

//               //circularButtonWidget(context, screenWidth),
//             ],
//           ),
//           SizedBox(height: screenWidth * 0.40),
//           // connectedStatusText(),

//           Obx(
//             () => Center(
//               child: Text(
//                 '${_controller.vpn.value.countryLong}',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Obx(() => connectedStatus(context)),

//           ///////////////////////

//           Obx(() => Center(
//                 child: CountDownTimer(
//                   startTimer:
//                       _controller.vpnState.value == VpnEngine.vpnConnected,
//                 ),
//               )),

//           //////////////////////

//           StreamBuilder<VpnStatus?>(
//             initialData: VpnStatus(),
//             stream: VpnEngine.vpnStatusSnapshot(),
//             builder: (context, snapshot) => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: HomeCard(
//                     title: '${snapshot.data?.byteOut ?? '0 kbps'}',
//                     subtitle: 'DOWNLOAD',
//                     icon: CircleAvatar(
//                       backgroundColor: Colors.transparent,
//                       radius: 30,
//                       child: Icon(
//                         Icons.arrow_downward,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: HomeCard(
//                     title: '${snapshot.data?.byteIn ?? '0 kbps'}',
//                     subtitle: 'UPLOAD',
//                     icon: CircleAvatar(
//                       backgroundColor: Colors.transparent,
//                       radius: 30,
//                       child: Icon(
//                         Icons.arrow_upward,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget upperCurvedContainer(BuildContext context) {
//   return ClipPath(
//       clipper: MyCustomClipper(),
//       child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//           height: 320,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: curveGradient,
//           )));
// }

// Widget _topRow() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         height: 50,
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: <Widget>[
//             Image.asset('assets/premiumcrown.png', height: 36),
//             SizedBox(width: 12),
//             Text(
//               'Go Premium',
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//       Semantics(
//         button: true,
//         child: InkWell(
//           onTap: () {
//             Get.to(() => NetworkTestScreen());
//           },
//           child: Container(
//             height: 50,
//             width: 50,
//             decoration: BoxDecoration(
//               color: bgColor,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Icon(Icons.info,
//                   size: 26, color: Colors.amberAccent.shade100),
//             ),
//           ),
//         ),
//       ),

//       //  DARK MODE BUTTON

//       // darkModeButton(Colors.amber)

//       // Semantics(
//       //   button: true,
//       //   child: InkWell(
//       //     onTap: () {

//       //     },
//       //     child: Container(
//       //       height: 50,
//       //       width: 50,
//       //       decoration: BoxDecoration(
//       //         color: bgColor,
//       //         borderRadius: BorderRadius.circular(8),
//       //       ),
//       //       child: Center(
//       //         child: Icon(Icons.light_mode_rounded,
//       //             size: 26, color: Colors.amberAccent.shade100),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     ],
//   );
// }

// Widget _bottomRow(String upload, String download) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Text(
//         upload,
//         style: txtSpeedStyle,
//       ),
//       Text(
//         download,
//         style: txtSpeedStyle,
//       ),
//     ],
//   );
// }

// // Widget circularButtonWidget(BuildContext context, width) {
// //   return Positioned(
// //     bottom: -width * 0.35,
// //     child: InkWell(
// //       borderRadius: BorderRadius.circular(100),
// //       onTap: () {
// //         _controller.connectToVpn();
// //         print('tapped on container/////////////');
// //       },
// //       child: Row(
// //         children: [
// //           Stack(
// //             alignment: Alignment.center,
// //             children: <Widget>[
// //               Container(
// //                 height: width * 0.51,
// //                 width: width * 0.51,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   gradient: curveGradient,
// //                   // color: Colors.red,
// //                 ),
// //                 child: Center(
// //                   child: Container(
// //                     height: width * 0.4,
// //                     width: width * 0.4,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       color: bgColor,
// //                     ),
// //                     child: Center(
// //                       child: Obx(
// //                         () => Container(
// //                           height: width * 0.3,
// //                           width: width * 0.3,
// //                           decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: _controller.getButtonColor,
// //                               boxShadow: [
// //                                 BoxShadow(
// //                                   color: Color.fromARGB(255, 5, 132, 217)
// //                                       .withOpacity(.2),
// //                                   spreadRadius: 15,
// //                                   blurRadius: 15,
// //                                 ),
// //                               ]),
// //                           child: Center(
// //                             child: Icon(Icons.wifi_lock,
// //                                 color: Colors.white, size: 50),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),

// //               //top left widget
// //               Positioned(
// //                 left: 8,
// //                 top: 30,
// //                 child: Container(
// //                   padding: EdgeInsets.all(8),
// //                   height: 60,
// //                   width: 60,
// //                   decoration:
// //                       BoxDecoration(color: bgColor, shape: BoxShape.circle),
// //                   child: Center(
// //                     child: CircleAvatar(
// //                       backgroundImage: _controller.vpn.value.countryLong.isEmpty
// //                           ? null
// //                           : AssetImage(
// //                               'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
// //                       radius: 40,
// //                       backgroundColor: Colors.transparent,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }

// // Widget connectedStatusText() {
// //   return Align(
// //     alignment: Alignment.center,
// //     child: RichText(
// //       textAlign: TextAlign.center,
// //       text: TextSpan(text: 'Status :', style: connectedStyle, children: [
// //         TextSpan(text: ' connected\n', style: connectedGreenStyle),
// //       ]),
// //     ),
// //   );
// // }

// Widget _vpnButton(BuildContext context) => Positioned(
//       bottom: MediaQuery.of(context).size.width * -0.30,
//       child: Column(
//         children: [
//           Semantics(
//             button: true,
//             child: InkWell(
//               onTap: () {
//                 _controller.connectToVpn();
//               },
//               borderRadius: BorderRadius.circular(100),
//               child: Container(
//                 padding: EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _controller.getButtonColor.withOpacity(.2),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _controller.getButtonColor.withOpacity(.3),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     height: MediaQuery.of(context).size.height * 0.137,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: _controller.getButtonColor,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.power_settings_new,
//                           size: 30,
//                           color: Colors.white,
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           _controller.getButtonText,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

// Widget connectedStatus(BuildContext context) {
//   return Container(
//     margin: EdgeInsets.only(
//       top: MediaQuery.of(context).size.height * 0.02,
//       bottom: MediaQuery.of(context).size.height * 0.02,
//     ),
//     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//     decoration: BoxDecoration(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.circular(15),
//     ),
//     child: Text(
//         _controller.vpnState.value == VpnEngine.vpnDisconnected
//             ? 'Not Connected'
//             : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
//         textAlign: TextAlign.center,
//         style: TextStyle(color: _controller.getButtonColor, fontSize: 25)),
//   );
// }

// Widget _changeLocation(BuildContext context) => SafeArea(
//       child: Semantics(
//         button: true,
//         child: InkWell(
//           onTap: () => Get.to(() => LocationScreen()),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15), color: bgColor),
//             //color: bgColor,
//             height: 50,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(9.0),
//                   child: Icon(
//                     CupertinoIcons.globe,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                 ),
//                 Text(
//                   'Change Location',
//                   style: TextStyle(
//                     backgroundColor: bgColor,
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       Icons.keyboard_arrow_right_rounded,
//                       color: Colors.black,
//                       size: 28,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
