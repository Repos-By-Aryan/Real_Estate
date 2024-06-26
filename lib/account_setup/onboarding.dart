//Incomplete backend

import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate/Utils/utils.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:share_plus/share_plus.dart';

import '../constants/constants.dart';
import '../home/property_detail.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});


  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final userDBref = FirebaseFirestore.instance.collection('Users');


  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var selectedImage;
  var imageUrl;

  get screenWidth => MediaQuery.of(context).size.width;

  Future<void> uploadData() async {
    Reference storageRef = FirebaseStorage.instance.ref();
    Reference profile_pic = storageRef.child(
        'profile_pics');
    String uniqueFileName = _auth.currentUser!.uid.toString();
    Reference referenceImageToUpload = profile_pic.child(
        uniqueFileName);
    try{
      await referenceImageToUpload.putFile(selectedImage);
      imageUrl = await referenceImageToUpload.getDownloadURL();
      await userDBref.doc(uniqueFileName).set({
        'name':nameController.text.toString(),
        'mobile' : mobileController.text.toString(),
        'email':_auth.currentUser!.email.toString(),
        'image' : imageUrl.toString(),
        'id':uniqueFileName.toString()
      });

    }catch(e){
      setState(() {
        loading=false;
      });
      Utils().toastMessage(e.toString());
    }
    setState(() {
      loading = false;
    });
    showModalBottomSheet(
        showDragHandle: true,
        constraints: BoxConstraints.expand(),
        context: context,
        builder: (BuildContext context){
          return Container(
            constraints: BoxConstraints.expand(),
            height: screenWidth*0.5,
            child: Column(
              children: [
                Container(
                  width:150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset('assets/svg/Alert-Success.svg'),
                ),
                SizedBox(height:10),
                RichText(
                  maxLines: 3,
                  text: TextSpan(
                      text: "Account ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          fontFamily: 'Lato',
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "successfully\n",
                          style: TextStyle(
                            color: Color(0xff234F68),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Lato',
                          ),
                        ),
                        TextSpan(
                            text: "created",
                            style:
                            TextStyle(fontSize: 30, color: Colors.black)),
                      ]),
                ),
                SizedBox(height:20),
                Text('Welcome to the iConicFeed family, glad to have you onboard.',maxLines:2,style: ratingStyle,),
                SizedBox(height:30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, RoutesName.mainScreen, arguments: {
                        'name':nameController.text.toString(),
                      });
                    },
                    child: Container(
                      width: screenWidth*0.65,
                      height:50,
                      decoration: BoxDecoration(
                        color: greenTheme,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:Text("Finish",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });

  }

  Future<void> pickImageWithSelection() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: (await showDialog<ImageSource>(
        context: context, // The context of your current widget
        builder: (BuildContext dialogContext) => AlertDialog( // Receive the dialog's context
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, ImageSource.camera), // Use dialogContext
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, ImageSource.gallery),
              child: Text('Gallery'),
            ),
          ],
        ),
      ))!,
    imageQuality: 80,
    );
    setState((){
      selectedImage = File(image!.path.toString());
    });

  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    mobileController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    emailController.text = _auth.currentUser!.email.toString();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar:AppBar(
        forceMaterialTransparency: true,
      leadingWidth: 70,
      leading: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xcbffffff),
          elevation: 0.2,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: const Icon(
          Icons.chevron_left,
          size: 23,
          color: Colors.black87,
        ),
      ),
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutesName.mainScreen);
              },
              child: const RoundedButton(title: "skip")),
        ),
      ],
    ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:10),
              RichText(
                maxLines: 3,
                text: TextSpan(
                    text: "Just a ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        fontFamily: 'Lato',
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: "little bit ",
                        style: TextStyle(
                          color: Color(0xff234F68),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato',
                        ),
                      ),
                      TextSpan(
                          text: "about you...",
                          style:
                          TextStyle(fontSize: 30, color: Colors.black)),
                    ]),
              ),
              SizedBox(height:10),
              Text('You can edit this later in settings', style: greyText,),
              SizedBox(height:20),
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap:(){
                        InteractiveViewer(child: Image(image: selectedImage,) );
              },
                      child: CircleAvatar(
                      radius: 60,
                        backgroundImage: selectedImage != null ? FileImage(selectedImage) as ImageProvider<Object>?: AssetImage('assets/images/blankpp.webp'),
              ),
                    ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: InkWell(
                      onTap: (){
                        pickImageWithSelection();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.mode_edit_outlined,color: Colors.white,size: 17,),
                        radius:15,
                      backgroundColor: theme,
                      ),
                    ),
                  )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          label: Text('Name'),
                          suffixIcon: Icon(Icons.account_circle_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius:BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          label: Text('Mobile Number'),
                          prefix: Text('+91 '),
                          suffixIcon: Icon(Icons.dialpad_rounded),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          if((value.length < 10) || (value.length>10)){
                            return 'Invalid mobile number';
                          }
                          if(value.length == 10){
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        readOnly: true,
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F4F8),
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffa7c8fc),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(
                              color: Color(0xffE4E7EB),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment:Alignment.bottomCenter,
                child:InkWell(
                  onTap: () async{
                    setState(() {
                      loading=true;
                    });
                    if(_formKey.currentState!.validate()) {
                      uploadData();
                    }
                  },
                  child: Container(
                    width: screenWidth*0.65,
                    height:50,
                    decoration: BoxDecoration(
                      color: greenTheme,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child:loading?CircularProgressIndicator(color: Colors.white,):Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                    ),
                  ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
