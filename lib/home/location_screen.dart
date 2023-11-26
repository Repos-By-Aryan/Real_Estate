import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LocationScreen extends StatelessWidget {
   const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/Homebackdrop.png')),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading:Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF5F4F8),
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
          ),
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, RoutesName.login);
                  },
                  child: const RoundedButton(title: "skip")),
            ),
          ],
        ),
        body:SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              RichText(
                maxLines: 3,
                text: const TextSpan(
                    text: "Add your ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        fontFamily: 'Lato',
                        color: Color(0xff252B5C)),
                    children: <TextSpan>[
                      TextSpan(
                        text: "location\n",
                        style: TextStyle(
                          color: Color(0xff234F68),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
