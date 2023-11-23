import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';
bool active = false;
class PropertyDetail extends StatelessWidget {
  const PropertyDetail({super.key});


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final firestore =
    FirebaseFirestore.instance.collection('listings').snapshots();
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    return Container(
    width: screenWidth,
    height: screenHeight,
    constraints: const BoxConstraints.expand(),
    child: Scaffold(

      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              
              Stack(
                children:[
                  StreamBuilder(
                    stream: firestore,

                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text("An error occurred.");
                      }
                      return SizedBox(
                        width: double.infinity,
                        height:180,
                        child: CarouselSlider(items:[] , options: CarouselOptions(),),
                      );
                      },
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF5F4F8),
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xcbffffff),
                            elevation: 0.2,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: const Icon(
                            Icons.file_upload_outlined,
                            size: 25,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(){
                              active = true;
                            };
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8ac73f),
                            elevation: 0.2,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: active?SvgPicture.asset('assets/svg/heart_w.svg',width: 25,),
                        ),
                      ],
                    ),
                  ],
                ),

                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),

            ],
          ),
        ),
      ),
    ),
    );
  }
}
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.green),
//       home: const PropertyDetail(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class PropertyDetail extends StatefulWidget {
//   const PropertyDetail({super.key});
//
//   @override
//   State<PropertyDetail> createState() => _PropertyDetailState();
// }
//
// class _PropertyDetailState extends State<PropertyDetail> {
//   List<File> selectedImages = [];
//   final picker = ImagePicker();
//   @override
//   Widget build(BuildContext context) {
//     // display image selected from gallery
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Multiple Images Select'),
//         backgroundColor: Colors.green,
//         actions: const [],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.green)),
//               child: const Text('Select Image from Gallery and Camera'),
//               onPressed: () {
//                 getImages();
//               },
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 18.0),
//               child: Text(
//                 "GFG",
//                 textScaleFactor: 3,
//                 style: TextStyle(color: Colors.green),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 width: 300.0,
//                 child: selectedImages.isEmpty
//                     ? const Center(child: Text('Sorry nothing selected!!'))
//                     : GridView.builder(
//                   itemCount: selectedImages.length,
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3),
//                   itemBuilder: (BuildContext context, int index) {
//                     return Center(
//                         child: kIsWeb
//                             ? Image.network(selectedImages[index].path)
//                             : Image.file(selectedImages[index]));
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future getImages() async {
//     final pickedFile = await picker.pickMultiImage(
//         imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
//     List<XFile> xfilePick = pickedFile;
//
//     setState(
//           () {
//         if (xfilePick.isNotEmpty) {
//           for (var i = 0; i < xfilePick.length; i++) {
//             selectedImages.add(File(xfilePick[i].path));
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Nothing is selected')));
//         }
//       },
//     );
//   }
// }
//
