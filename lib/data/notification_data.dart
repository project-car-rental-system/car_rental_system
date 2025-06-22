import 'package:flutter/material.dart';

List<Map<String, dynamic>> notifications = [
  {
    'title': 'Special Promotion!',
    'message': 'Get 20% off all SUV bookings this week.',
    'icon': Icons.local_offer_rounded,
    'color': Colors.purple,
  },
];

void addNotification({
  required String title,
  required String message,
  required IconData icon,
  required Color color,
}) {
  notifications.insert(0, {
    'title': title,
    'message': message,
    'icon': icon,
    'color': color,
  });
}
