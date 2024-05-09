

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate/Utils/utils.dart';
import 'package:real_estate/get_data/listing_model.dart';



class UserData{
  final _auth = FirebaseAuth.instance;
  String? userID;
  Map<String,dynamic>? userData;
  final userDBref = FirebaseFirestore.instance.collection('Users');
  Future<void> getUserData() async{
    userID = _auth.currentUser!.uid.toString();
    await FirebaseFirestore.instance.collection('Users').doc(userID).get().then((DocumentSnapshot doc){
      userData = doc.data() as Map<String,dynamic>;
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
  }
}


class ListingsData{
  List<ListingModel>? listingDocs;
  final listingDBref = FirebaseFirestore.instance.collection('listings').get();

  Future<void> fetchListingsData()async{
    await FirebaseFirestore.instance.collection('listings').snapshots().listen((snapshot) {
      listingDocs = snapshot.docs.map((doc) => ListingModel(
        id : doc["id"],
        title: doc['title'],
        address: doc['address'],
        area: doc['area'],
        category: doc['category'],
        facilities: doc['facilities'],
        features: doc['features'],
        image_urls: doc['image_urls'],
        price: doc['price'],
        type: doc['type'],
        rating: doc['rating'],
      )).toList();
      // notifyListeners();
    });
  }
}
