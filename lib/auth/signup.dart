import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate/routes/routes_name.dart';

import '../Utils/utils.dart';
import '../constants/constants.dart';

class SignUp extends StatefulWidget {
  static const String id = 'SignUp';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  Color visibilityColor = const Color(0xFF62a6f7);
  bool visibility = true;
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  // final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
// Dispose method to dispose the email and password after signup.
  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  void signUp(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){
        setState(() {
          loading = false;
        });
        // Navigator.pushReplacementNamed(context, Login.id);
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
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
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/images/Logo.png",
                            width: 60,
                            height: 60,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Center(child: Text("Create your account", style: heading)),
                        SizedBox(height: screenHeight * 0.02),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    fillColor: const Color(0xffF8F9FA),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.mail_outline,
                                      color: Color(0xff323F4B),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE4E7EB),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE4E7EB),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: TextFormField(
                                  obscureText: visibility,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    fillColor: const Color(0xffF8F9FA),
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.lock_open,
                                      color: Color(0xff323F4B),
                                    ),
                                    suffixIcon: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            if (count % 2 == 0) {
                                              visibility = false;
                                              visibilityColor = Colors.black87;
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
                                      borderSide: const BorderSide(
                                        color: Color(0xffE4E7EB),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE4E7EB),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight *0.03,
                        ),
                        Container(
                          width: screenWidth*0.65,
                          height:50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              signUp();
                            },
                            child:  Center(
                              child: loading ? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,):const Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
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
        ),
      ),
    );
}
}
