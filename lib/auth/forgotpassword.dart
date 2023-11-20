import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils/utils.dart';
import '../constants/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  "assets/images/Logo.png",
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(child: Text("Reset your password", style: heading)),
              SizedBox(height: screenHeight * 0.02),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: const Color(0xffF8F9FA),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.alternate_email,
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
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    auth.sendPasswordResetEmail(
                        email: emailController.text.toString())
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(
                          'We have sent a password reset link on your email');
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Center(
                    child: loading
                        ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                        : const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily:'Lato' ,fontSize: 15)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
