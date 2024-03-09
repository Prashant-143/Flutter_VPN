import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';

import '../controllers/home_controller.dart';
import '../helpers/preference.dart';

class NewHomeCard extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();

  final String title;
  final String subtitle;
  final Widget icon;

  NewHomeCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.090),
      padding: EdgeInsets.all(0.5),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).borderColor),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 0,
        color: bgColor,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: Container(
            padding: EdgeInsets.all(.5),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).borderColor),
                borderRadius: BorderRadius.circular(6)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png',
                height: 40,
                width: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.cover,
              ),
            ),
          ),
          tileColor: bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon,
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).lightText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Theme.of(context).lighSubtitleText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _controller.vpn.value.ping,
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
                Icons.equalizer,
                color: Pref.isDarkMode ? Colors.green : Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
