import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;

  const NetworkCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * 0.02,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).borderColor,
            ), // Set the border color here
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            // Flag
            leading: Icon(data.icon.icon,
                color: data.icon.color, size: data.icon.size ?? 28),

            // Title
            title: Text(
              data.title,
              style: TextStyle(
                color: Theme.of(context).lightText,
              ),
            ),

            // Subtitle
            subtitle: Text(
              data.subtitle,
              style: TextStyle(
                color: Theme.of(context).lightText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
