//Incomplete backend

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        forceMaterialTransparency: true,
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
        child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          label: Text('Name'),
                          suffixIcon: Icon(Icons.account_circle_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius:BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          label: Text('Mobile Number'),
                          prefix: Text('+91 '),
                          suffixIcon: Icon(Icons.dialpad_rounded),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if(value.length < 10){
                            return 'Invalid mobile number';
                          }
                          if(value.length > 10){
                            return 'Invalid mobile number';
                          }
                          if(value.length == 10){
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        readOnly: true,
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment:Alignment.bottomCenter,
                child:InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){

                    }
                    showModalBottomSheet(
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context){
                      return SizedBox(
                        height: screenWidth*0.5,
                        child: Column(
                          children: [
                            Container(
                              width:100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xff234f688),
                                    Color(0xff8bc83f),
                                    Color(0xdf234f68),
                                    Color(0xaf234f68),
                                    // Replace with the color at the edges of your gradient
                                  ],
                                  stops: [0.4,0.8,0.9, 1.0],
                                  // Adjust these values to change the size and transition of the gradient
                                ),
                              ),
                              child: Icon(
                                Icons.check, // Replace with the icon you want to display
                                color: Colors.white,
                                size: 50.0, // Adjust the size of the icon as needed
                              ),
                            ),

                            Center(child: TextButton(child:Text("Close"),onPressed: (){
                            Navigator.pop(context);
                          },),),],
                        ),
                      );
                    });

                  },
                  child: Container(
                    width: screenWidth*0.65,
                    height:50,
                    decoration: BoxDecoration(
                      color: greenTheme,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child:Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                    ),
                  ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
