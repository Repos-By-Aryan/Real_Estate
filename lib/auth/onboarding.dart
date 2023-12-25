import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/constants.dart';
import '../home/property_detail.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _auth = FirebaseAuth.instance;


  void checkNewUser(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      leadingWidth: 70,
      leading: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xcbffffff),
          elevation: 0.2,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: const Icon(
          Icons.chevron_left,
          size: 23,
          color: Colors.black87,
        ),
      ),
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
              onTap: () {
              },
              child: const RoundedButton(title: "skip")),
        ),
      ],
    ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            RichText(
              maxLines: 3,
              text: TextSpan(
                  text: "Fill your ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      fontFamily: 'Lato',
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: "information\n",
                      style: TextStyle(
                        color: Color(0xff234F68),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lato',
                      ),
                    ),
                    TextSpan(
                        text: "below",
                        style:
                        TextStyle(fontSize: 30, color: Colors.black)),
                  ]),
            ),
            SizedBox(height:10),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/blankpp.webp'),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: CircleAvatar(
                    child: Icon(Icons.mode_edit_outlined,color: Colors.white,size: 17,),
                    radius:15,
                  backgroundColor: theme,
                  ),
                )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
