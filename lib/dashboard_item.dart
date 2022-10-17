import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.handler});

  final String label;
  final IconData icon;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () {
              handler();
            },
            child: Container(
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                constraints:
                    const BoxConstraints(minHeight: 100, maxWidth: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon),
                    Text(label),
                  ],
                ))));
  }
}
