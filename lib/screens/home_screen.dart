import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/preference.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/internet_speed_test.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import '../controllers/home_controller.dart';
import '../models/vpn_status.dart';
import '../screens/location_screen.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import '../services/vpn_engine.dart';
import '../widgets/new_home_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    // // Initialize Connectivity
    // ConnectivityResult _previousResult = ConnectivityResult.none;
    // Connectivity().onConnectivityChanged.listen((result) {
    //   if (_previousResult != ConnectivityResult.none &&
    //       result == ConnectivityResult.none) {
    //     // Disconnect VPN when the network connection is lost
    //     // VpnEngine.openKillSwitch();
    //   }
    //   _previousResult = result;
    // });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomNav,
        elevation: 1,
        leading: IconButton(
          tooltip: 'SPEED TEST',
          padding: EdgeInsets.only(right: 5),
          onPressed: () => Get.to(() => InternetSpeedTest(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 500)),
          icon: Icon(
            CupertinoIcons.speedometer,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text("NUCLEUS VPN"),
        actions: [
          IconButton(
            tooltip: 'IP INFO',
            padding: EdgeInsets.only(right: 5),
            onPressed: () => Get.to(() => NetworkTestScreen(),
                transition: Transition.upToDown),
            icon: Icon(
              CupertinoIcons.info,
              color: Colors.white,
              size: 28,
            ),
          ),
          darkModeButton(Colors.white),
        ],
      ),

      //Change Location Button...
      bottomNavigationBar: _changeLocation(context),

      //Body
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Obx(() => _vpnButton(context)),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expanded(
              //   child: HomeCard(
              //     subtitle: 'FREE',
              //     title: _controller.vpn.value.countryLong.isEmpty
              //         ? 'Country'
              //         : _controller.vpn.value.countryLong,
              //     icon: CircleAvatar(
              //       backgroundColor: Colors.blue,
              //       radius: 30,
              //       child: _controller.vpn.value.countryLong.isEmpty
              //           ? Icon(
              //               Icons.vpn_lock_rounded,
              //               color: Colors.white,
              //             )
              //           : null,
              //       backgroundImage: _controller.vpn.value.countryLong.isEmpty
              //           ? null
              //           : AssetImage(
              //               'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: HomeCard(
              //     title: _controller.vpn.value.countryLong.isEmpty
              //         ? '100 ms'
              //         : _controller.vpn.value.ping + ' ms',
              //     subtitle: 'PING',
              //     icon: CircleAvatar(
              //       radius: 30,
              //       backgroundColor: Colors.orange,
              //       child: Icon(
              //         Icons.equalizer,
              //         size: 30,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: NewHomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? 'Country'
                      : _controller.vpn.value.countryLong,
                  subtitle: 'Free',
                  icon: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: _controller.vpn.value.countryLong.isEmpty
                        ? Icon(
                            Icons.vpn_lock_rounded,
                            color: Colors.white,
                          )
                        : null,
                    backgroundImage: _controller.vpn.value.countryLong.isEmpty
                        ? null
                        : AssetImage(
                            'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: HomeCard(
                    title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                    subtitle: 'DOWNLOAD',
                    icon: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: HomeCard(
                  title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                  subtitle: 'UPLOAD',
                  icon: CircleAvatar(
                    backgroundColor:
                        Pref.isDarkMode ? Colors.cyan.shade500 : Colors.blue,
                    radius: 30,
                    child: Icon(
                      Icons.upload_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _vpnButton(BuildContext context) => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _controller.getButtonColor.withOpacity(.2),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.3),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.137,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          _controller.getButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
              color: _controller.getButtonColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),

          // FOR SHOWING OLD AND NEW IP ADDRESS

          Obx(() => CountDownTimer(
                startTimer:
                    _controller.vpnState.value == VpnEngine.vpnConnected,
              )),
          Text(
            'IP: ${"152.59.67.84"}',
            style: TextStyle(
                color: Theme.of(context).lightText,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ],
      );

  Widget _changeLocation(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen(),
                transition: Transition.zoom,
                duration: Duration(milliseconds: 500)),
            child: Container(
              color: Theme.of(context).bottomNav,
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Icon(
                      CupertinoIcons.globe,
                      color: Theme.of(context).cardColor,
                      size: 32,
                    ),
                  ),
                  Text(
                    'Change Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.cyan,
                        size: 28,
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
