import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notification_screen.dart'; // Import screen noti

class BookingSummaryScreen extends StatelessWidget {
  final String userName;
  final Map<String, dynamic> selectedCar;
  final String pickupLocation;
  final String returnLocation;
  final DateTime startDate;
  final DateTime endDate;

  const BookingSummaryScreen({
    super.key,
    required this.userName,
    required this.selectedCar,
    required this.pickupLocation,
    required this.returnLocation,
    required this.startDate,
    required this.endDate,
  });

  int getRentalDays() => endDate.difference(startDate).inDays + 1;
  num getTotalPrice() => getRentalDays() * selectedCar['price'];

  void _showFinalConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.green[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              "Booking Confirmed",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "✅ Your booking has been successfully confirmed.\nThank you!",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => NotificationScreen(
                            newNotification: {
                              'title': 'Booking Confirmed',
                              'message':
                                  'You booked ${selectedCar['name']} on ${DateFormat('dd MMM yyyy').format(startDate)}.',
                              'icon': Icons.check_circle,
                              'color': Colors.green,
                            },
                          ),
                    ),
                  );
                },
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  Widget _buildRow(
    String labelWithIcon,
    String value, {
    Color valueColor = Colors.white,
    bool isBold = false,
    double fontSize = 16,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              labelWithIcon,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy • hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BOOKING DETAIL',
          style: TextStyle(
            color: Colors.lightBlueAccent, // Warna teks ditukar di sini
            fontWeight: FontWeight.bold, // Optional: bagi lebih menonjol
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: const Color(0xFF1B263B),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  selectedCar['image'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow("👤 Name:", userName),
                      _buildRow("🚗 Car:", selectedCar['name']),
                      _buildRow("📍 Pickup:", pickupLocation),
                      _buildRow("📦 Return:", returnLocation),
                      _buildRow("📅 Start:", formatter.format(startDate)),
                      _buildRow("🕒 End:", formatter.format(endDate)),
                      const SizedBox(height: 10),
                      _buildRow("📆 Total Days:", getRentalDays().toString()),
                      _buildRow(
                        "💰 Total Price:",
                        "RM : ${getTotalPrice().toStringAsFixed(2)}",
                        valueColor: Colors.greenAccent,
                        isBold: true,
                        fontSize: 18,
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => _showFinalConfirmation(context),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text("Confirm Booking"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "⬅ Back",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
