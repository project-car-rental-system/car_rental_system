import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Solid dark blue background
          Container(color: const Color(0xFF0D1B2A)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // 🚗 Car icon with border only (no shadow)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, (1 - value) * -50),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(
                          255,
                          6,
                          80,
                          164,
                        ).withOpacity(0.1),
                        border: Border.all(
                          color: const Color.fromARGB(255, 152, 175, 221),
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.directions_car_filled_rounded,
                          size: 80,
                          color: Color.fromARGB(255, 147, 199, 229),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🧾 Main title
                  Text(
                    'Drive Your Dream Today!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 159, 203, 247),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 📱 Description text
                  Text(
                    'SmartDrive brings you a smart, smooth, and stylish way to rent cars in just a few taps.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ⭐ Feature icons grid
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFeatureIcon(Icons.verified_user, 'Trusted'),
                            _buildFeatureIcon(Icons.speed, 'Instant Booking'),
                            _buildFeatureIcon(
                              Icons.car_rental,
                              'Latest Models',
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildFeatureIcon(Icons.phone_android, 'Easy App'),
                            _buildFeatureIcon(
                              Icons.security,
                              'Insurance Included',
                            ),
                            _buildFeatureIcon(
                              Icons.support_agent,
                              '24/7 Support',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // ▶️ Get Started button
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 900),
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔧 Reusable feature icon + label widget
  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 15, 99, 244), size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.openSans(
            color: const Color.fromARGB(250, 250, 248, 248),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
