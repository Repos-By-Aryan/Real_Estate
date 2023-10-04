import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/constants/constants.dart';

class One extends StatelessWidget {
  static const String id = 'One';
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('assets/images/Logo.png'),
        ),
        automaticallyImplyLeading: true,
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: RoundedButton(title: "skip"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.06,
            ),
            RichText(
              maxLines: 2,
              text: const TextSpan(
                  text: "Find best place\n",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "to stay in ",
                        style: TextStyle(fontSize: 33, color: Colors.black)),
                    TextSpan(
                      text: "good price",
                      style: TextStyle(
                        color: Color(0xff003d64),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: Align(
                alignment:Alignment.bottomCenter,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  width: screenWidth,
                  height: screenHeight*0.65,
                  decoration: BoxDecoration(
                    image:const DecorationImage(image: AssetImage('assets/images/one.jpg'),
                    fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
