import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices{

  bool isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null){
      return true;
    }
    else{
      return false;
    }
  }
}