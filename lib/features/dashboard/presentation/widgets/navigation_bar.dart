import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashboardNavigationBar extends StatelessWidget {
  const DashboardNavigationBar({super.key, required this.items, this.onTap});
  final List<Widget> items;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: items,
      onTap: onTap,
    );
  }
}
