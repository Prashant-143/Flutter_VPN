import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/vpn_model.dart';

late final mq;

class Pref {
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

// For String Theme Data

  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

// For storing last used vpn data

  static VpnModel get vpn =>
      VpnModel.fromJson(jsonDecode(_box.get('vpn') ?? '{}'));
  static set vpn(VpnModel v) => _box.put('vpn', jsonEncode(v));

// For storing vpn servers deatils

  static List<VpnModel> get vpnList {
    List<VpnModel> temp = [];
    final data = jsonDecode(_box.get('vpnList') ?? '[]');

    for (var i in data) {
      temp.add(VpnModel.fromJson(i));
    }
    return temp;
  }

  static set vpnList(List<VpnModel> v) => _box.put('vpnList', jsonEncode(v));
}
