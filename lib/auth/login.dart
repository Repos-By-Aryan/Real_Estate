// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/Utils/utils.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/splash_services/splash_services.dart';
import 'package:real_estate/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  Color visibilityColor = const Color(0xFF62a6f7);
  bool visibility = true;
  int count = 1;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });
      Utils().toastMessage(value.user!.email.toString());
      // if(()){Navigator.pushNamed(context, RoutesName.mainScreen);}
    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Backdrop.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(
                  width: screenWidth<400?screenWidth * 0.85:screenWidth*0.8,
                  height: screenHeight<800?screenHeight * 0.85:screenHeight * 0.63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height:10),
                          Image.asset(
                            "assets/images/Logo.png",
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text("Sign in to your account", style: heading),
                          SizedBox(height: screenHeight * 0.01), // SizedBox()
                          InkWell(
                              onTap: () {
                              },
                              child: SignInButton(
                                  title: "Sign in with Google",
                                  logo: "assets/images/GoogleIcon.png",
                                  width: screenWidth * 0.65)),
                          SizedBox(height: screenHeight * 0.01), // SizedBox()
                          InkWell(
                              onTap: () {
                                _auth.signInAnonymously();
                                if(_auth.currentUser!.isAnonymous){
                                  Navigator.pushNamed(context, RoutesName.homeScreen);
                                }
                              },
                              child: SignInButton(
                                  title: "Continue as Guest",
                                  logo: "assets/images/AppleIcon.png",
                                  width: screenWidth * 0.65)),
                          SizedBox(height: screenHeight * 0.01), // SizedBox()
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  color: Colors.grey,
                                  height: 1,
                                ),
                              ),
                              Text("Or continue with", style: TextStyle(color: Colors.grey)),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  color: Colors.grey,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email address',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xffa7c8fc),
                                        ),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xffE4E7EB),
                                        ),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter email';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: visibility,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      suffixIcon: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (count % 2 == 0) {
                                                visibility = false;
                                                visibilityColor = const Color(0xff4C5980);
                                                count++;
                                              } else {
                                                visibility = true;
                                                visibilityColor = const Color(0xFF62a6f7);
                                                count++;
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.visibility_off_outlined,
                                            color: visibilityColor,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: Color(0xffa7c8fc),
                                        ),
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: Color(0xffE4E7EB),
                                        ),
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter password';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, RoutesName.ForgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                login();
                              }
                            },
                              child: Container(
                                width: screenWidth*0.65,
                                height:50,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child:loading?CircularProgressIndicator(strokeWidth: 3,color:Colors.white,):Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                                ),
                              ),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal:70 ),
              child: Container(
                height:40,
                constraints: BoxConstraints(minWidth: screenWidth*0.8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0x55cdacbc),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,RoutesName.signUp);
                      },
                      child: const Text(
                        ' Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          decorationColor: Colors.white,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
