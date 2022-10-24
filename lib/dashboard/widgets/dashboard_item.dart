import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.handler,
      required this.mode});

  final String label;
  final IconData icon;
  final Function handler;
  final String mode;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    double ratio = 3;
    if (mode == 'minimized') ratio = 4;
    if (mode == 'maximized') ratio = 2;
    return GestureDetector(
      onTap: () {
        handler();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: (totalHeight - appBarHeight) / ratio,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: mode == 'maximized'
              ? Colors.blue.shade50
              : Theme.of(context).cardColor,
          border: Border.all(color: Colors.black),
        ),
        constraints: const BoxConstraints(minHeight: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: mode == 'maximized' ? Colors.blue : null,
            ),
            Text(
              label,
              style: mode == 'maximized'
                  ? Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.blue)
                  : Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
