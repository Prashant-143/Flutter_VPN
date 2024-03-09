import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/location_controller.dart';
import '../helpers/preference.dart';
import '../main.dart';
import '../widgets/vpn_card.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _controller = LocationController();

  final TextEditingController _searchVpn = TextEditingController();

  bool _showSearch = false;
  // Variable to track whether to show the search field
  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) {
      _controller.getVPNData();
    }

    return Obx(
      () => Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).bottomNav,
          actions: [
            darkModeButton(Colors.white),

            // Toggle search visibility when search icon is tapped
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
            ),
          ],
          title: Text(
            "VPN Servers (${_controller.vpnList.length})",
            style: TextStyle(fontSize: 15),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: FloatingActionButton(
            backgroundColor:
                Pref.isDarkMode ? Colors.cyan.shade500 : Colors.blue,
            onPressed: () => _controller.getVPNData(),
            child: Icon(CupertinoIcons.refresh),
          ).animate().scale(duration: Duration(milliseconds: 600)),
        ),
        body: _controller.isLoading.value
            ? _loadingWidget(context)
            : _controller.vpnList.isEmpty
                ? _noVPNFound(context)
                : _vpnData(context),
      ),
    );
  }

  Widget _vpnData(BuildContext context) {
    return Column(
      children: [
        // Show text field only if _showSearch is true
        Visibility(
          visible: _showSearch,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8).copyWith(top: 10),
            child: Container(
                child: TextField(
                  controller: _searchVpn,
                  onChanged: (value) {
                    _controller.filterVPNs(_searchVpn.text);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search VPNs',
                    hintStyle: TextStyle(
                        color: Pref.isDarkMode ? Colors.white : Colors.black),
                    prefixIcon: Icon(Icons.search,
                        color: Pref.isDarkMode ? Colors.white : Colors.black),
                  ),
                  style: TextStyle(
                      color: Pref.isDarkMode ? Colors.white : Colors.black),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).borderColor),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _searchVpn.text.isEmpty
                ? _controller.vpnList.length
                : _controller.filteredVPNList.length,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.015,
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
            ),
            itemBuilder: (ctx, i) => _searchVpn.text.isEmpty
                ? VpnCard(vpn: _controller.vpnList[i])
                : VpnCard(vpn: _controller.filteredVPNList[i]),
          ),
        ),
      ],
    );
  }

  Widget _loadingWidget(BuildContext context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/loading.json',
              height: 400,
            ),
            Text(
              'Loading VPNs...😊',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.bold,
              ),
            ).animate().scale(duration: Duration(milliseconds: 700)),
          ],
        ),
      );

  Widget _noVPNFound(BuildContext context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/SadEmoji1.json',
              height: 200,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'VPNs Not Found! 😞',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ).animate().scale(duration: Duration(milliseconds: 500));
}
