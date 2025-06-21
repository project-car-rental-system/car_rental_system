import 'package:flutter/material.dart';
import 'booking_screen.dart'; // Import the booking screen

class CarDetailScreen extends StatelessWidget {
  final int index;

  const CarDetailScreen({super.key, required this.index});

  // Sample data for car details
  static final List<Map<String, dynamic>> carData = [
    {
      "name": "Toyota Vios",
      "image": "assets/images/vios.jpg",
      "passenger": 5,
      "price": "RM150/day",
      "speed": "180 km/h",
      "battery": "45 L Petrol",
      "volume": "470 L",
      "seats": "5",
      "soundSystem": "Standard Audio",
      "fuelType": "Petrol",
      "transmission": "Automatic",
      "carType": "Sedan",
    },
    {
      "name": "Honda City",
      "image": "assets/images/city.jpg",
      "passenger": 5,
      "price": "RM200/day",
      "speed": "185 km/h",
      "battery": "45 L Petrol",
      "volume": "519 L",
      "seats": "5",
      "soundSystem": "8 Speaker System",
      "fuelType": "Petrol",
      "transmission": "CVT Automatic",
      "carType": "Sedan",
    },
    {
      "name": "Perodua Myvi",
      "image": "assets/images/myvi.jpg",
      "passenger": 5,
      "price": "RM120/day",
      "speed": "170 km/h",
      "battery": "36 L Petrol",
      "volume": "277 L",
      "seats": "5",
      "soundSystem": "Basic Audio System",
      "fuelType": "Petrol",
      "transmission": "Automatic",
      "carType": "Hatchback",
    },
    {
      "name": "Proton X70",
      "image": "assets/images/x70.jpg",
      "passenger": 5,
      "price": "RM250/day",
      "speed": "195 km/h",
      "battery": "60 L Petrol",
      "volume": "512 L",
      "seats": "5",
      "soundSystem": "Premium Audio by Kenwood",
      "fuelType": "Petrol",
      "transmission": "7-Speed DCT",
      "carType": "SUV",
    },
  ];

  // Widget for each specification row
  Widget buildSpecRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = carData[index];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(200, 13, 27, 42), // Dark blue
        title: Text(car['name']),
        elevation: 0, // No shadow
      ),
      body: Container(
        // Solid dark blue background (no gradient or shadow)
        color: const Color(0xFF0D1B2A),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car image without shadow
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  car['image'],
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Car name
              Text(
                car['name'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              // Car price
              Text(
                car['price'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white),

              const Text(
                "Car Specifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              const SizedBox(height: 10),

              // All specification rows
              buildSpecRow(
                Icons.people,
                "Passenger Capacity",
                "${car['passenger']} persons",
                Colors.indigoAccent,
              ),
              buildSpecRow(
                Icons.speed,
                "Top Speed",
                car['speed'],
                Colors.deepPurpleAccent,
              ),
              buildSpecRow(
                Icons.battery_charging_full,
                "Battery Capacity",
                car['battery'],
                Colors.tealAccent,
              ),
              buildSpecRow(
                Icons.local_mall,
                "Boot Volume",
                car['volume'],
                Colors.orangeAccent,
              ),
              buildSpecRow(
                Icons.event_seat,
                "Seating",
                "${car['seats']} seats",
                Colors.brown,
              ),
              buildSpecRow(
                Icons.speaker,
                "Sound System",
                car['soundSystem'],
                Colors.purpleAccent,
              ),
              buildSpecRow(
                Icons.local_gas_station,
                "Fuel Type",
                car['fuelType'],
                Colors.redAccent,
              ),
              buildSpecRow(
                Icons.settings,
                "Transmission",
                car['transmission'],
                Colors.blueGrey,
              ),
              buildSpecRow(
                Icons.directions_car,
                "Car Type",
                car['carType'],
                Colors.cyan,
              ),

              const SizedBox(height: 25),

              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              const SizedBox(height: 8),

              // Car description
              Text(
                "The ${car['name']} is a stylish and reliable ${car['carType']} ideal for both city and long-distance drives. With a spacious cabin for ${car['passenger']} passengers, a ${car['soundSystem']} sound system, and efficient ${car['fuelType']} fuel consumption, it's perfect for your next journey.",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.lightBlueAccent,
                ),
              ),

              const SizedBox(height: 30),

              // Booking and Back buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(car: car),
                          ),
                        );
                      },
                      icon: const Icon(Icons.car_rental),
                      label: const Text("Booking Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          91,
                          161,
                          240,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
