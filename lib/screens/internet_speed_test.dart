import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vpn_basic_project/helpers/preference.dart';
import 'package:vpn_basic_project/main.dart';

class InternetSpeedTest extends StatefulWidget {
  const InternetSpeedTest({super.key});

  @override
  State<InternetSpeedTest> createState() => _InternetSpeedTestState();
}

class _InternetSpeedTestState extends State<InternetSpeedTest> {
  double _displayProgress = 0.0;
  double _downloadRate = 0.0;
  double _uploadRate = 0.0;
  double displayRate = 0.0;
  bool isServerSelectionInProgress = false;

  String? _isp;
  String? _asp;
  String? _asn;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Internet Speed Test'),
        backgroundColor: Theme.of(context).bottomNav,
        centerTitle: true,
        actions: [
          darkModeButton(Colors.white),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height),
          Text(
            "Progress",
            style: TextStyle(
                color: Theme.of(context).lightText,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            percent: _displayProgress,
            progressColor: Colors.orange,
            center: Text(
              _displayProgress.toStringAsFixed(1) + "%",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            lineHeight: 18,
            barRadius: Radius.circular(10),
            animation: true,
          ),
          SizedBox(height: height),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download Rate',
                      style: TextStyle(
                          color: Theme.of(context).lightText,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height),
                    Text(
                      'Upload Rate',
                      style: TextStyle(
                          color: Theme.of(context).lightText,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _downloadRate.toStringAsFixed(2),
                      style: TextStyle(
                          color: Theme.of(context).lightText,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height),
                    Text(
                      _uploadRate.toStringAsFixed(2),
                      style: TextStyle(
                          color: Theme.of(context).lightText,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height),
          SfRadialGauge(
            axes: [
              RadialAxis(
                radiusFactor: 0.85,
                minorTicksPerInterval: 1,
                tickOffset: 3,
                useRangeColorForAxis: true,
                interval: 4,
                minimum: 0,
                maximum: 100,

                showLastLabel: true,

                // labelOffset: 10,
                axisLabelStyle: GaugeTextStyle(
                    color: Pref.isDarkMode ? Colors.cyan : Colors.blue),
                ranges: [
                  GaugeRange(
                    color: Pref.isDarkMode ? Colors.cyan : Colors.blue,
                    startValue: 0,
                    endValue: 99,
                    startWidth: 5,
                    endWidth: 10,
                  ),
                ],
                pointers: [
                  NeedlePointer(
                    value: displayRate,
                    enableAnimation: true,
                    needleColor: Colors.deepOrange,
                    tailStyle: TailStyle(
                      color: Colors.white,
                      borderWidth: 0.01,
                      borderColor: Colors.white,
                    ),
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        borderWidth: 0.01,
                        borderColor: Colors.red),
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        displayRate.toStringAsFixed(2),
                        style: TextStyle(
                            color: Theme.of(context).lightText,
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.7,
                  )
                ],
              ),
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            isServerSelectionInProgress
                ? 'Selecting Server'
                : 'IP: ${_isp ?? '_'} | ASP: ${_asp ?? '_'} | ISP: ${_asn ?? '_'}',
            style: TextStyle(
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Pref.isDarkMode ? Colors.cyan : Colors.blue),
            onPressed: () {},
            child: Text('Start Testing', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  tesInternetSpeed() {}
}
