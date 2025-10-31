import 'package:flutter/material.dart';

class News {
  final String title;
  final String source;
  final String time;
  final String category;
  final IconData icon;
  final Color categoryColor;

  News({
    required this.title,
    required this.source,
    required this.time,
    required this.category,
    required this.icon,
    required this.categoryColor,
  });
}
