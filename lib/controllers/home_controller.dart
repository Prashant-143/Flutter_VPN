import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import '../helpers/preference.dart';
import '../models/vpn_model.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnModel> vpn = Pref.vpn.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() {
    // Logic for connecting to VPN
    if (vpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      // log('\nBefor: ${vpn.value.openVPNConfigDataBase64}' as num);

      final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
          country: vpn.value.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);

      // Start if the stage is disconnected
      VpnEngine.startVpn(vpnConfig);
    } else {
      // Stop if the stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

// VPN Button Color

  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Pref.isDarkMode
            ? Colors.cyan.withOpacity(0.8)
            : Colors.blue.withOpacity(0.7);
      case VpnEngine.vpnConnected:
        return Colors.green.shade400;
      default:
        return Colors.orangeAccent;
    }
  }

  // VPN Button Text

  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return "Tap to connect";

      case VpnEngine.vpnConnected:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }
}
