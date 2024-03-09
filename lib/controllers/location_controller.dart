import 'dart:developer';

import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/preference.dart';
import 'package:vpn_basic_project/models/vpn_model.dart';

class LocationController extends GetxController {
  List<VpnModel> vpnList = Pref.vpnList;

  var filteredVPNList = <VpnModel>[].obs;

  final RxBool isLoading = false.obs;

  // Future<void> getVPNData() async {
  //   isLoading.value = true;
  //   vpnList.clear();
  //   vpnList = await APIs.getVPNServers();
  //   isLoading.value = false;
  // }

  @override
  void onInit() {
    super.onInit();
    getVPNData();
  }

  Future<void> getVPNData() async {
    isLoading(true);
    try {
      //Fetch VPN & Assign data to vpnList
      vpnList.clear();
      vpnList = await APIs.getVPNServers();
      filteredVPNList.assignAll(vpnList);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      log("Error fetching VPN data: $e");
      MyDialogs.error(msg: 'Some Error Occured While Fetching Vpn Data');
    }
  }

  void filterVPNs(String query) {
    if (query.isEmpty) {
      filteredVPNList
          .assignAll(vpnList); // Show all VPNs when search query is empty
      return;
    }
    final filtered = vpnList.where((vpn) {
      return vpn.countryLong.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredVPNList.assignAll(filtered);
  }
}
