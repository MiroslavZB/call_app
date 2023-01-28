import 'package:flutter/material.dart';

class NavigationBarTabItem extends BottomNavigationBarItem {
  const NavigationBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);

  final String initialLocation;
}
