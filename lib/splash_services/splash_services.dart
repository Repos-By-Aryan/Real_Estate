import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/Utils/utils.dart';
import 'package:real_estate/get_data/all_data.dart';
import 'package:real_estate/routes/routes_name.dart';

class SplashServices {
  ListingsData listingsDataObj = ListingsData();
  UserData userDataObj = UserData();
  final auth = FirebaseAuth.instance;


  Future<void> isLogin(BuildContext context) async {
    final user = auth.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, RoutesName.mainScreen);
      await userDataObj.getUserData();
      // debugPrint(userDataObj.userData.toString());
    }
    else {
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
    // await listingsDataObj.fetchListingsData();
  }


  void checkGuestLogin(BuildContext context) {
    if (auth.currentUser!.isAnonymous) {
      Utils().toastMessage("Please Login to continue.");
      Navigator.pushNamed(context, RoutesName.login);
    }
  }
}

