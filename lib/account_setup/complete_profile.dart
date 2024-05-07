import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/home/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/utils.dart';
import '../constants/constants.dart';

class CompleteUserProfileScreen extends StatefulWidget {
  const CompleteUserProfileScreen({super.key});

  @override
  State<CompleteUserProfileScreen> createState() =>
      _CompleteUserProfileScreenState();
}

class _CompleteUserProfileScreenState extends State<CompleteUserProfileScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var selectedGender;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  File? _image;
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  var userID;
  final firestoreRef = FirebaseFirestore.instance.collection("Users");
  List<String> genderItems = ["Male", "Female", "Not prefer to say"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = auth.currentUser!.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 95.0, bottom: 5),
                      child: Text(
                        "Complete Your Profile",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      "Dont't worry, only you can see your personal",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Myfont1",
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                    Text(
                      "data. No one can else will be able to see it.",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Myfont1",
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Container(
                        height: 140,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 67,
                              backgroundImage: _image != null
                                  ? FileImage(_image!.absolute)
                                  : null,
                              backgroundColor: Color.fromRGBO(
                                  35, 36, 37, 0.33725490196078434),
                              child: _image == null
                                  ? Center(
                                      child: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                      size: 85,
                                    ))
                                  : null,
                            ),
                            Positioned(
                              left: screenWidth * 0.22,
                              top: screenHeight * 0.11,
                              child: InkWell(
                                onTap: () {
                                  getGalleryImage();
                                },
                                child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 22,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Myfont1",
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: SizedBox(
                            height: screenHeight * 0.062,
                            width: screenWidth * 0.94,
                            child: TextFormField(
                              controller: nameController,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Myfont1",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: "Enter Name",
                                filled: true,
                                fillColor: Color.fromRGBO(
                                    199, 206, 217, 0.7333333333333333),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Myfont1",
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: SizedBox(
                            height: screenHeight * 0.062,
                            width: screenWidth * 0.94,
                            child: TextFormField(
                              controller: emailController,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Myfont1",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                hintText: "Enter e-mail",
                                filled: true,
                                fillColor: Color.fromRGBO(
                                    199, 206, 217, 0.7333333333333333),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Myfont1",
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: SizedBox(
                            height: screenHeight * 0.062,
                            width: screenWidth * 0.94,
                            child: DropdownButtonFormField(
                              items: genderItems
                                  .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Myfont1",
                                            fontWeight: FontWeight.w700),
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                selectedGender = value;
                              },
                              onSaved: (value) {
                                selectedGender = value;
                              },
                              isExpanded: true,
                              hint: Text(
                                "Select your Gender",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Myfont1",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                              // dropdownStyleData: DropdownStyleData(
                              //     direction: DropdownDirection.left,
                              //     width: screenWidth * 0.45,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15))),
                              // buttonStyleData: ButtonStyleData(
                              //     padding: EdgeInsets.only(right: 8.0)),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                //hintText: "Select your Gender",
                                filled: true,
                                fillColor: Color.fromRGBO(
                                    199, 206, 217, 0.7333333333333333),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(
                                            199, 206, 217, 0.7333333333333333),
                                        width: 2)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2)),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return "Please select gender";
                                }
                                return null;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: SizedBox(
                        height: screenHeight * 0.068,
                        width: screenWidth * 0.95,
                        child:Text("Hello"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Button(
  // btnname: "Complete Profile",
  // loading: loading,
  // onpressed: () {
  // if (_formKey.currentState!.validate()) {
  // uploadImage();
  // }
  // }),

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint("No image picked");
      }
    });
  }

  Future uploadImage() async {
    final storageRef =
        FirebaseStorage.instance.ref("UserProfileImages/" + userID);
    setState(() {
      loading = true;
    });
    UploadTask uploadTask = storageRef.putFile(_image!.absolute);

    uploadTask.then((value) async {
      var imageURL = await storageRef.getDownloadURL();

      firestoreRef.doc(userID).set({
        "User-id": userID,
        "Profile-URL": imageURL,
        "Name": nameController.text.trim(),
        "Email": emailController.text.toString(),
        "Gender": selectedGender
      }).then((value) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage("Uploaded");
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage(error.toString());
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
          (route) => false);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
}

