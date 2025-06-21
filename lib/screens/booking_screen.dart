import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:intl/intl.dart';
import 'booking_summary_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required Map<String, dynamic> car});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  String selectedPickup = 'Main Branch';
  String selectedReturn = 'Main Branch';

  late Map<String, dynamic> selectedCar;

  final List<Map<String, dynamic>> carList = [
    {
      'name': 'Toyota Vios',
      'image': 'assets/images/vios.jpg',
      'passenger': 4,
      'price': 150.0,
    },
    {
      'name': 'Honda City',
      'image': 'assets/images/city.jpg',
      'passenger': 4,
      'price': 200.0,
    },
    {
      'name': 'Perodua Myvi',
      'image': 'assets/images/myvi.jpg',
      'passenger': 4,
      'price': 120.0,
    },
    {
      'name': 'Proton X70',
      'image': 'assets/images/x70.jpg',
      'passenger': 5,
      'price': 250.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedCar = carList[0];
  }

  Future<void> _pickDateTime({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      isStart ? startDate = fullDateTime : endDate = fullDateTime;
    });
  }

  int getRentalDays() {
    if (startDate == null || endDate == null) return 0;
    return endDate!.difference(startDate!).inDays + 1;
  }

  num getTotalPrice() => getRentalDays() * selectedCar['price'];

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy • hh:mm a');

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white.withOpacity(0.1),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/header_car_bg.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🚗 ', style: TextStyle(fontSize: 30)),
                          const SizedBox(width: 8),
                          Text(
                            '"BOOK A CAR"',
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    _buildTextField('Your Name', nameController),
                    const SizedBox(height: 20),

                    _buildDropdownCar(),
                    const SizedBox(height: 20),

                    _buildDateTile(
                      'Start Date & Time',
                      startDate,
                      () => _pickDateTime(isStart: true),
                      formatter,
                    ),
                    _buildDateTile(
                      'End Date & Time',
                      endDate,
                      () => _pickDateTime(isStart: false),
                      formatter,
                    ),

                    const SizedBox(height: 20),
                    _buildLocationDropdown(
                      'Pickup Location',
                      selectedPickup,
                      (val) => setState(() => selectedPickup = val!),
                    ),
                    const SizedBox(height: 20),
                    _buildLocationDropdown(
                      'Return Location',
                      selectedReturn,
                      (val) => setState(() => selectedReturn = val!),
                    ),

                    const SizedBox(height: 30),

                    if (startDate != null && endDate != null) ...[
                      _buildInfoText('📅 Total Days: ${getRentalDays()}'),
                      _buildInfoText(
                        '💰 Total Price: RM ${getTotalPrice().toStringAsFixed(2)}',
                      ),
                    ],

                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: _confirmBooking,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Book Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        '⬅ Back',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDropdownCar() {
    return DropdownButtonFormField<Map<String, dynamic>>(
      value: selectedCar,
      dropdownColor: Colors.blueGrey[900],
      items:
          carList.map((car) {
            return DropdownMenuItem(
              value: car,
              child: Text(
                car['name'],
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
      onChanged: (val) => setState(() => selectedCar = val!),
      decoration: InputDecoration(
        labelText: 'Select Car Model',
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildDateTile(
    String label,
    DateTime? value,
    VoidCallback onTap,
    DateFormat formatter,
  ) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white10,
      title: Text(
        value == null ? label : formatter.format(value),
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.calendar_today, color: Colors.white),
      onTap: onTap,
    );
  }

  Widget _buildLocationDropdown(
    String label,
    String value,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: Colors.blueGrey[900],
      items:
          ['Main Branch', 'Airport', 'City Centre'].map((loc) {
            return DropdownMenuItem(
              value: loc,
              child: Text(loc, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  void _confirmBooking() {
    if (nameController.text.isEmpty || startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BookingSummaryScreen(
              userName: nameController.text,
              selectedCar: selectedCar,
              pickupLocation: selectedPickup,
              returnLocation: selectedReturn,
              startDate: startDate!,
              endDate: endDate!,
            ),
      ),
    );
  }
}
