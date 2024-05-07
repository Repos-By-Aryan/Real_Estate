
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/Utils/utils.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/splash_services/splash_services.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      // SharedPreferences sp = await SharedPreferences.getInstance();
      // sp.setString('id', user!.uid);
      // sp.setString('username', user.displayName.toString());

      Navigator.pushNamed(context, RoutesName.mainScreen,arguments:{
        'id' : user!.uid,
        'username' : "${user!.displayName}!\n",
      });
      // Use the user object for further operations or navigate to a new screen.
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }
  void login() {
   late final User user;
    setState(() {
      loading =true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value) {
      setState(() {
        user = _auth.currentUser!;
        loading = false;
      });
      Navigator.pushReplacementNamed(context, RoutesName.mainScreen,arguments: {
        'id' : user.uid,
        'username' : "${user.displayName.toString()}!\n",
      });
      debugPrint("${user.displayName.toString()}!\n");
      Utils().toastMessage("Signed in successfully");
    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
      debugPrint("$error");
      Utils().toastMessage(error.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: ModalProgressHUD(
        inAsyncCall: loading,
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
                              onTap: () async{
                                setState(() {
                                  loading=true;
                                });
                                await signInWithGoogle();
                                setState(() {
                                  loading=false;
                                });
                              },
                              child: SignInButton(
                                  title: "Sign in with Google",
                                  logo: "assets/images/GoogleIcon.png",
                                  width: screenWidth * 0.65)),
                          SizedBox(height: screenHeight * 0.01), // SizedBox()
                          InkWell(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                await _auth.signInAnonymously(); // Add 'await' to ensure the sign-in is completed before moving forward
                                bool? isLogin = _auth.currentUser?.isAnonymous;
                                if (isLogin != null && isLogin){
                                  // Navigator.pushNamed(context, RoutesName.mainScreen);
                                  setState(() {
                                    loading=false;
                                  });
                                }
                                setState(() {
                                  loading=false;
                                });
                                Navigator.pushNamed(context, RoutesName.mainScreen,arguments: {
                                  'username':'Guest!\n',
                                });

                              },
                              child:SignInButton(
                                  title: "Continue as Guest",
                                  logo: "assets/images/Guest.png",
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
                                              visibility = !visibility;
                                              if(visibility){
                                                visibilityColor = const Color(0xff4C5980);
                                              }
                                              else{
                                                visibilityColor = const Color(0xFF62a6f7);
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
                              Navigator.pushNamed(context, RoutesName.forgotPassword);
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
                                  child:Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
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
