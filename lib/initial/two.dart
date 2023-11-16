import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/routes/routes_name.dart';

class Two extends StatefulWidget {
  static const String id = 'Two';
  const Two({super.key});

  @override
  State<Two> createState() => _TwoState();
}



class _TwoState extends State<Two> {
  bool isSecondTextVisible=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('assets/images/Logo.png'),
        ),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, RoutesName.mainScreen);
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
                      'Fast sell your property\nin just',
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
                    'one click',
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
                      constraints: const BoxConstraints.tightFor(),
                      width: screenWidth,
                      height: screenHeight * 0.65,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/two.jpg'),
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
                      padding:  EdgeInsets.only(bottom: screenHeight*0.035),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesName.three);
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
