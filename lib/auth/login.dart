import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/splash_services/splash_services.dart';
import 'package:real_estate/Utils/utils.dart';

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
      var login = SplashServices().isLogin(context);
      // if(login){Navigator.pushNamed(context, PostScreen.id);}
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
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            onTap: () {},
                            child: SignInButton(
                                title: "Sign in with Google",
                                logo: "assets/images/GoogleIcon.png",
                                width: screenWidth * 0.65)),
                        SizedBox(height: screenHeight * 0.01), // SizedBox()
                        InkWell(
                            onTap: () {},
                            child: SignInButton(
                                title: "Sign in with Apple",
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
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
                                              visibilityColor = const Color(0xff4C5980);
                                              count++;
                                            } else {
                                              visibility = true;
                                              visibilityColor = const Color(0xFF62a6f7);
                                              count++;
                                            }
                                          });
                                        },
                                        // style: ElevatedButton.styleFrom(
                                        //   elevation: 0,
                                        //   backgroundColor: Colors.transparent,
                                        // ),
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
