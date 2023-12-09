import 'package:flutter/material.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/routes/routes_name.dart';

class Three extends StatelessWidget {
  static const String id = 'Three';
  const Three({super.key});

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
              height: screenHeight * 0.06,
            ),
            RichText(
              maxLines: 2,
              text: const TextSpan(
                  text: "Find ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      fontFamily: 'Lato',
                      color: Colors.black),
                  children: <TextSpan>[

                    TextSpan(
                      text: "perfect choice ",
                      style: TextStyle(
                        color: Color(0xff234F68),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,

                      ),
                    ),
                    TextSpan(
                        text: "for\n",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    TextSpan(
                        text: "your future house",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                  ]
              ),
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
                            image: AssetImage('assets/images/three.jpg'),
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
                            Navigator.pushReplacementNamed(context, RoutesName.login);
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
