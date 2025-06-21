import 'package:flutter/material.dart';

// Import screens
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/car_list_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/notification_screen.dart';

// Import service
import 'services/auth_service.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatefulWidget {
  const CarRentalApp({super.key});

  @override
  State<CarRentalApp> createState() => _CarRentalAppState();
}

class _CarRentalAppState extends State<CarRentalApp> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      // Welcome screen sebagai screen pertama
      initialRoute: '/',

      // Senarai route lengkap
      routes: {
        '/': (context) => const WelcomeScreen(), // 👉 Muka depan
        '/login':
            (context) =>
                LoginScreen(authService: _authService), // 👉 Login page
        '/register':
            (context) => RegisterScreen(
              authService: _authService,
              onRegister: () => Navigator.pop(context),
            ), // 👉 Register
        '/home': (context) => const HomeScreen(), // 👉 Lepas login
        '/calendar': (context) => const CalendarScreen(),
        '/car_list': (context) => CarListScreen(),
        '/booking': (context) => const BookingScreen(car: {}),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}
