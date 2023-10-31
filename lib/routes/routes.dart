
import 'package:flutter/material.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/home/bottom_navbar.dart';
import 'package:real_estate/home/home_screen.dart';
import 'package:real_estate/home/promotion.dart';
import 'package:real_estate/search/search.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/splash_services/splash_screen.dart';

import '../initial/one.dart';
import '../initial/three.dart';
import '../initial/two.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.one:
        return MaterialPageRoute(builder: (context) => const One());
      case RoutesName.two:
        return MaterialPageRoute(builder: (context) => const Two());
      case RoutesName.three:
        return MaterialPageRoute(builder: (context) => const Three());
      case RoutesName.promotion:
        return MaterialPageRoute(builder: (context) => const Promotion());
        case RoutesName.search:
        return MaterialPageRoute(builder: (context) => const Search());
   case RoutesName.bottomNavBar:
        return MaterialPageRoute(builder: (context) => const BottomNavBar());

      default:
        return MaterialPageRoute(
          builder:(context) { return const Scaffold(
            body: Center(child: Text("No route found"),),
          );}
        );
    }
  }
}