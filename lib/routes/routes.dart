import 'package:flutter/material.dart';
import 'package:real_estate/account_setup/profile_screen.dart';
import 'package:real_estate/auth/forgotpassword.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/account_setup/onboarding.dart';
import 'package:real_estate/home/favourite.dart';
import 'package:real_estate/home/home_screen.dart';
import 'package:real_estate/home/location_screen.dart';
import 'package:real_estate/home/main_screen.dart';
import 'package:real_estate/home/promotion.dart';
import 'package:real_estate/home/property_detail.dart';
import 'package:real_estate/home/view_all.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/search/location_results.dart';
import 'package:real_estate/search/search.dart';
import 'package:real_estate/splash_services/splash_screen.dart';

import '../auth/signup.dart';
import '../initial/one.dart';
import '../initial/three.dart';
import '../initial/two.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) =>  const HomeScreen());
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
      case RoutesName.mainScreen:
        return MaterialPageRoute(builder: (context) =>  MainScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());
        case RoutesName.locationScreen:
        return MaterialPageRoute(
            builder: (context) => LocationScreen());
      case RoutesName.propertyDetail:
        return MaterialPageRoute(
            builder: (context) =>
                PropertyDetail(data: settings.arguments as Map));
        case RoutesName.allproperty:
          return MaterialPageRoute(
            builder: (context) =>
                ViewAll(data: settings.arguments as Map));
          case RoutesName.locationResult:
          return MaterialPageRoute(
            builder: (context) =>
                LocationResultScreen(data: settings.arguments as Map));
          case RoutesName.onboarding:
          return MaterialPageRoute(
            builder: (context) =>
                Onboarding());
          case RoutesName.favourite:
          return MaterialPageRoute(
            builder: (context) =>
                Favourites());
          case RoutesName.profile:
          return MaterialPageRoute(
            builder: (context) =>
                ProfileScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No route found"),
            ),
          );
        });
    }
  }
}
