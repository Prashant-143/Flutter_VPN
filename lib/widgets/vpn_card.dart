import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../helpers/preference.dart';
import '../main.dart';
import '../models/vpn_model.dart';
import '../services/vpn_engine.dart';

import '../helpers/my_dialogs.dart';

class VpnCard extends StatelessWidget {
  final VpnModel vpn;

  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    final controller = Get.find<HomeController>();

    return Card(
      color: bgColor,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 05,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          controller.vpn.value = vpn;
          Pref.vpn = vpn;
          Get.back();

          MyDialogs.success(msg: 'Connecting to VPN Location...');

          if (controller.vpnState.value == VpnEngine.vpnDisconnected) {
            VpnEngine.stopVpn();
            Future.delayed(
                Duration(milliseconds: 2500), () => controller.connectToVpn());
          } else {
            controller.connectToVpn();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).borderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            leading: Container(
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).borderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                  height: MediaQuery.of(context).size.width * 0.12,
                  width: MediaQuery.of(context).size.width * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title
            title: Text(
              vpn.countryLong,
              style: TextStyle(color: Theme.of(context).lightText),
            ),

            // Subtitle
            subtitle: Row(
              children: [
                Icon(
                  Icons.speed_rounded,
                  color: Pref.isDarkMode ? Colors.green : Colors.blue,
                  size: 21,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  _formatBytes(vpn.speed, 1),
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).lightText,
                  ),
                ),
              ],
            ),

            // Trailing
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vpn.numVpnSessions.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightText,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.people_alt_rounded,
                  color: Pref.isDarkMode ? Colors.green : Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().scale(duration: Duration(milliseconds: 800)).then().shimmer();
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
