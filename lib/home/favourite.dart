import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estate/constants/constants.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favourite",style: subheading,),
        centerTitle: true,
      ),
      body:SafeArea(
          minimum: EdgeInsets.all(10),
          child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("0 estates",style: boldText,),
          Center(
            child: Container(
              constraints: BoxConstraints.tightForFinite(width: screenWidth,height: screenHeight*0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width:screenWidth*0.5,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset('assets/svg/Add-Success.svg'),
                    ),
                  ),
                  SizedBox(height:10),
                  RichText(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    text: const TextSpan(
                        text: "Your favourite page is\n",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            fontFamily: 'Lato',
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "empty",
                            style: TextStyle(
                              color: Color(0xff234F68),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height:20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: RichText(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        text: TextSpan(text: 'Click add button above to start exploring and choose your favourite estates.',style: TextStyle(
                        fontSize: 12,  fontWeight: FontWeight.w700, color: Color(0xff53587A),fontFamily: 'Lato'),)),
                  ),
                  SizedBox(height:30),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
