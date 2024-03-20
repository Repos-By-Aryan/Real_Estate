import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/routes/routes_name.dart';

class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null) {
      Navigator.pushReplacementNamed(
          context, RoutesName.mainScreen, arguments: {
        'id': user.uid,
        'username': "${user.displayName.toString().split(" ")[0]}!\n",});
    }
    else if(user!.isAnonymous){
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    }
    else{
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
  }
  }
