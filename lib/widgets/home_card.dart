import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;

  const HomeCard({
    Key? key, // Use Key instead of super.key
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45,
      child: Column(
        children: [
          //icon
          icon,

          //for adding some space
          const SizedBox(height: 6),

          //title
          Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).lightText,
              )),

          //for adding some space
          const SizedBox(height: 6),

          //subtitle
          Text(
            subtitle,
            style: TextStyle(
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
