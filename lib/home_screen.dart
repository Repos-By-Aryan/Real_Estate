// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(

        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/Homebackdrop.png')),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                ],
              ),
            ],
          ),
        ))
      ),
    );
  }
}
