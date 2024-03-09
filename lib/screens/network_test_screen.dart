import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/Ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

import '../apis/apis.dart';
import '../helpers/preference.dart';

class NetworkTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomNav,
        title: Text('Network Test Screen'),
        actions: [darkModeButton(Colors.white)],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: FloatingActionButton(
          backgroundColor: Pref.isDarkMode ? Colors.cyan.shade500 : Colors.blue,
          onPressed: () {
            ipData.value = IPDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
          },
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            top: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.1,
          ),
          children: [
            // IP
            NetworkCard(
              data: NetworkData(
                title: 'IP Address',
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.red,
                ),
                subtitle: ipData.value.query,
              ),
            ),

            // ISP
            NetworkCard(
              data: NetworkData(
                title: 'Internet Provider',
                icon: Icon(
                  Icons.business,
                  color: Colors.orange,
                ),
                subtitle: ipData.value.isp,
              ),
            ),

            // LOCATION
            NetworkCard(
              data: NetworkData(
                title: 'Location',
                icon: Icon(
                  CupertinoIcons.location,
                  color: Colors.cyan,
                ),
                subtitle: ipData.value.country.isEmpty
                    ? 'Fetching...'
                    : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
              ),
            ),

            // PIN CODE
            NetworkCard(
              data: NetworkData(
                title: 'Pin Code',
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.blue,
                ),
                subtitle: ipData.value.zip,
              ),
            ),

            //LATITUDE & LONGITUDE

            NetworkCard(
              data: NetworkData(
                title: 'Latitude & Longitude',
                icon: Icon(
                  CupertinoIcons.globe,
                  color: Colors.red,
                ),
                subtitle: '${ipData.value.lat.toString()}',
              ),
            ),

            // TIMEZONE
            NetworkCard(
              data: NetworkData(
                title: 'Timezone',
                icon: Icon(
                  CupertinoIcons.time,
                  color: Colors.green,
                ),
                subtitle: ipData.value.timezone,
              ),
            ),
          ],
        ).animate().shimmer(duration: Duration(seconds: 2)),
      ),
    );
  }
}
