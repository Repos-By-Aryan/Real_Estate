import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


final _auth = FirebaseAuth.instance;
var selectedGender;
bool loading = false;
final _formKey = GlobalKey<FormState>();

var selectedImage;
final picker = ImagePicker();
String? userID;
Map<String,dynamic>? userData;
final userDBref = FirebaseFirestore.instance.collection('Users');
List<String> genderItems = ["Male", "Female", "Not prefer to say"];


void getUserData(){
  userID = _auth.currentUser!.uid.toString();
  userDBref.doc(userID).get().then((DocumentSnapshot doc) {
    userData = doc.data() as Map<String, dynamic>;
  }).onError((error, stackTrace) {
    debugPrint(error.toString());
  });
  selectedImage = userData?['image'].toString();
}



class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 70,
        title: RichText(
          maxLines: 3,
          text: const TextSpan(
              text: "Your ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: "Account",
                  style: TextStyle(
                    color: Color(0xff234F68),
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato',
                  ),
                ),
              ]),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 5,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              ),
              child: Icon(Icons.settings,color: Colors.blueGrey,)),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:10),
                Stack(
                  children: [
                    GestureDetector(
                      onTap:(){
                        InteractiveViewer(child: CachedNetworkImage(imageUrl: selectedImage));
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: selectedImage != null ? NetworkImage(selectedImage) as ImageProvider<Object>?: const AssetImage('assets/images/blankpp.webp'),
                      ),
                    ),
                    const Positioned(
                      bottom: 2,
                      right: 2,
                      child: CircleAvatar(
                        radius:15,
                        backgroundColor: theme,
                        child: Icon(Icons.mode_edit_outlined,color: Colors.white,size: 17,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(userData?['name'],style: boldText),
                Text(userData?['email'],style: greyText),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
