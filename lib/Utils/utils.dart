// ignore_for_file: prefer_const_constructors

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xDA000000),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}