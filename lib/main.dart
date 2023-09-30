import 'package:flutter/material.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/splash_services/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Estate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context) => const SplashScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
      },
    );
  }
}

