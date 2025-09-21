import 'package:flutter/material.dart';

class BottomNavigationItem {
  final String label;
  final IconData icon;
  final Widget page;

  BottomNavigationItem({
    required this.label,
    required this.icon,
    required this.page,
  });
}
