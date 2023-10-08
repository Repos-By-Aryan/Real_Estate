
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/home_screen.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/splash_services/splash_screen.dart';

import '../initial/one.dart';
import '../initial/three.dart';
import '../initial/two.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.one:
        return MaterialPageRoute(builder: (context) => One());
      case RoutesName.two:
        return MaterialPageRoute(builder: (context) => Two());
      case RoutesName.three:
        return MaterialPageRoute(builder: (context) => Three());
      default:
        return MaterialPageRoute(
          builder:(context) { return Scaffold(
            body: Center(child: Text("No route found"),),
          ),}
        );
    }
  }
}