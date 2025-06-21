import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;

  const LoginScreen({super.key, required this.authService});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() {
    final success = widget.authService.login(_username.text, _password.text);
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      final msg =
          widget.authService.isRegistered
              ? 'Invalid username or password.'
              : "You didn't register yet.";
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Login Failed'),
              content: Text(msg),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 📸 Real background image
          SizedBox.expand(
            child: Image.asset('assets/images/real_bg.jpg', fit: BoxFit.cover),
          ),

          // 🌫 Blur overlay
          Container(color: Colors.black.withOpacity(0.5)),

          // UI utama
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 🚗 Logo kereta
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      size: 80,
                      color: Color.fromARGB(255, 238, 239, 240),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'SmartDrive brings you a smart, smooth, and stylish way to rent cars in just a few taps.!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'MEMBER LOGIN',
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Username
                          TextField(
                            controller: _username,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          TextField(
                            controller: _password,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Butang Login
                          CustomButton(
                            text: 'Login',
                            color: const Color.fromARGB(255, 53, 121, 152),
                            onPressed: _login,
                          ),
                          const SizedBox(height: 10),

                          // Butang Register
                          CustomButton(
                            text: 'Sign Up',
                            color: const Color.fromARGB(255, 14, 58, 104),
                            onPressed:
                                () => Navigator.pushNamed(context, '/register'),
                          ),
                        ],
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
}
