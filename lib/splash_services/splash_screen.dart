import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController? _controller;
  Animation<Color>? animation;

  final colors = <TweenSequenceItem<Color>>[
    TweenSequenceItem(tween: Tween<Color>(begin:Colors.red,end:Colors.blue),
        weight: 1.0),
    TweenSequenceItem(tween: Tween<Color>(begin: Colors.blue,end:Colors.green), weight: 1.0),
    

  ]
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffffeec3),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.network(

                  "https://lottie.host/0700d1eb-386a-439c-9575-972bc68be6d7/RImRjs8p8D.json",
                  width: screenWidth,
                  height: screenHeight /4,
                  fit: BoxFit.cover,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}













