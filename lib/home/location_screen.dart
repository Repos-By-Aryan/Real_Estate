import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LocationScreen extends StatefulWidget {
   const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
   final locationController = TextEditingController();
   final _auth = FirebaseAuth.instance;

   @override
   void dispose() {
     super.dispose();
     locationController.dispose();
   }

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        ),
        body:SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                RichText(
                  maxLines: 1,
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
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Container(
                      constraints:BoxConstraints.tightForFinite(height:350,),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        image: DecorationImage(image: AssetImage('assets/images/map.png'))
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                  child: TextFormField(
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text('City / State'),
                      hintText: 'Enter city name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffa7c8fc),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffE4E7EB),
                          ),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment:Alignment.bottomCenter,
                    child:InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: screenWidth*0.65,
                        height:50,
                        decoration: BoxDecoration(
                          color: Color(0xff8bc83f),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child:Text("Apply",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                        ),
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
