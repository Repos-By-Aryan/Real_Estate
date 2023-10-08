import 'package:flutter/material.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/firebase_options.dart';
import 'package:real_estate/home_screen.dart';
import 'package:real_estate/splash_services/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'initial/one.dart';
import 'initial/two.dart';
import 'initial/three.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
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
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffedf4ff)),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context) => const SplashScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        HomeScreen.id:(context) => const HomeScreen(),
        One.id:(context) => const One(),
        Two.id:(context) => const Two(),
        Three.id:(context) => const Three(),
      },
    );
  }
}

