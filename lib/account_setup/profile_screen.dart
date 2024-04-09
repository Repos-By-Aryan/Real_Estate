import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final _auth = FirebaseAuth.instance;

void getUserData(){

}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 70,
        title: RichText(
          maxLines: 3,
          text: TextSpan(
              text: "Your ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: ''
                      'Lato',
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "Account",
                  style: TextStyle(
                    color: Color(0xff234F68),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato',
                  ),
                ),
              ]),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      ),
    );
  }
}
