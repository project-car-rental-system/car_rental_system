import 'package:flutter/material.dart';

List<Map<String, dynamic>> notifications = [
  {
    'title': 'Return Reminder',
    'message': 'Please return Myvi by 14 June before 5 PM.',
    'icon': Icons.warning_amber_rounded,
    'color': Colors.amber,
  },
  {
    'title': 'Special Promotion!',
    'message': 'Get 20% off all SUV bookings this week.',
    'icon': Icons.local_offer_rounded,
    'color': Colors.purple,
  },
  {
    'title': 'Car Returned',
    'message': 'Toyota Vios was returned successfully on 10 June.',
    'icon': Icons.directions_car_filled,
    'color': Colors.blue,
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
