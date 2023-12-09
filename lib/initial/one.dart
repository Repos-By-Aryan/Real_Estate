import 'package:flutter/material.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:real_estate/routes/routes_name.dart';


class One extends StatefulWidget {
  static const String id = 'One';
  const One({super.key});

  @override
  State<One> createState() => _OneState();
}

class _OneState extends State<One> {
  bool isSecondTextVisible=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      setState(() {
        isSecondTextVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('assets/images/Logo.png'),
        ),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                },
                child: const RoundedButton(title: "skip")),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight*0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  displayFullTextOnTap: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Find best place\nto stay in',
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Colors.black),
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                ),
                if (isSecondTextVisible)
                  const Text(
                    'good price',
                    style: TextStyle(
                      color: Color(0xff003d64),
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Stack(
                children:[ Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: const BoxConstraints.tightForFinite(),
                    width: screenWidth,
                    height: screenHeight * 0.65,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/one.webp'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  ),
                ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: screenHeight*0.03),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.two);
                        },
                        child: Container(
                          width: screenWidth*0.65,
                          height:50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child:Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                          ),
                        ),),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
