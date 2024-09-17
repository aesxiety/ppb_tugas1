import 'package:flutter/material.dart';
import 'package:ppb_tugas1/pages/home_app.dart';
import 'package:ppb_tugas1/pages/booking_page.dart';
import 'package:ppb_tugas1/pages/profile.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeApp(),
        '/booking': (context) => const BookingPage(orders: []),
        '/profile': (context) => const ProfileApp(),
      },
    );
  }
}

void main() {
  runApp(const MainApp());
}
