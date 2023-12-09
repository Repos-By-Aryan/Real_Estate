import 'package:banner_carousel/banner_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/search/search.dart';

import '../constants/constants.dart';

bool active = false;

class PropertyDetail extends StatefulWidget {
  final data;
  const PropertyDetail({super.key, required this.data});

  @override
  State<PropertyDetail> createState() => _PropertyDetailState();
}

List imageUrls = [];

List featureIcon = [Icons.balcony_outlined,Icons.bathtub_rounded,Icons.bedroom_parent_outlined];

class _PropertyDetailState extends State<PropertyDetail> {
  String formatValue(var value) {
    if (value >= 10000000) {
      double valueInCr = value / 10000000.0;
      return '${valueInCr.toStringAsFixed(1)} Cr';
    } else if (value >= 100000) {
      double valueInL = value / 100000.0;
      return '${valueInL.toStringAsFixed(1)} L';
    } else if (value >= 1000) {
      double valueInK = value / 1000.0;
      return '${valueInK.toStringAsFixed(1)} k';
    } else {
      return value.toString();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final firestore =
        FirebaseFirestore.instance.collection('listings').snapshots();
    int extraIndex =-2;
    String mystr ="";
    // final property = FirebaseFirestore.instance.collection('listings').doc(widget.data['id']);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or a loading indicator
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Clear the existing list
          List<BannerModel> bannerImage = [];
          var desiredDocument = snapshot.data!.docs.firstWhere(
            (doc) => doc.id == widget.data['id'],
          );
          // Populate the list with data from Firestore
          var imageArray = List<String>.from(
              desiredDocument['image_urls']); // Retrieve the image_urls array
          var id = desiredDocument.id; // Use doc.id to get the document ID

          for (var imagePath in imageArray) {
            bannerImage.add(BannerModel(imagePath: imagePath, id: id));
          }
          var featureCount = desiredDocument.get('features') as Map;
          List feature = [];
          featureCount.forEach((key,value) {
            feature.add(key.toString());
            feature.add(value.toString());
          });
          var facilities = desiredDocument.get('facilities') as Map;
          List facilitiesKey = [];
          List facilitiesVal = [];
          facilities.forEach((key, value) {
            facilitiesKey.add(key);
            facilitiesVal.add(value);
          });
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
                        children: [
                          BannerCarousel.fullScreen(
                            banners: bannerImage,
                            customizedIndicators: IndicatorModel.animation(
                                width: 20,
                                height: 5,
                                spaceBetween: 2,
                                widthAnimation: 50),
                            height: screenHeight * 0.5,
                            activeColor: theme,
                            disableColor: Colors.white,
                            animation: true,
                            borderRadius: screenHeight * 0.05,
                            indicatorBottom: false,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
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
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {

                                    },
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
                                      setState(() {
                                        active = !active;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: active
                                          ? greenTheme
                                          : const Color(0xcbffffff),
                                      elevation: 0.2,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    child: active
                                        ? SvgPicture.asset(
                                            'assets/svg/heart_w.svg',
                                            width: 25,
                                          )
                                        : Image.asset('assets/images/heart.png',
                                            width: 25),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 18,
                            left: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff234F68),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10,
                                ),
                                child: Text(
                                  desiredDocument.get('category').toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 18,
                            left: 18,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff234F68),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      child: SvgPicture.asset(
                                        'assets/svg/star.svg',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        desiredDocument
                                            .get('rating')
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            desiredDocument.get('title').toString(),
                            style: subheading,
                          ),
                          Text("₹ "+
                            (desiredDocument.get('type')['rent']
                                ? formatValue(desiredDocument
                                    .get('price')['rent']['monthly'])
                                : formatValue(
                                    desiredDocument.get('price')['sell'])),
                            style: subheading,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                child: SvgPicture.asset(
                                  'assets/svg/location.svg',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                desiredDocument
                                        .get('address')['locality']
                                        .toString() +
                                    ', ' +
                                    desiredDocument
                                        .get('address')['city']
                                        .toString(),
                                style: text,
                              ),
                            ],
                          ),
                          Text(
                            desiredDocument.get('type')['rent']
                                ? 'per month'
                                : '',
                            style: text,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(right: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            color: desiredDocument.get('type')['rent']?greenTheme:Color(
                                0xffffffff),
                            shadowColor: desiredDocument.get('type')['rent']?greenTheme:Color(
                                0xffffffff),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              child: Center(
                                  child: Text('Rent',
                                      style: TextStyle(color: desiredDocument.get('type')['rent']?Colors.white:Colors.black,))),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(right: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            color: desiredDocument.get('type')['sell']?greenTheme:Color(
                                0xffffffff),
                            shadowColor: desiredDocument.get('type')['sell']?greenTheme:Color(
                                0xffffffff),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              child: Center(
                                  child: Text('Buy',
                                      style: TextStyle(color: desiredDocument.get('type')['sell']?Colors.white:Colors.black,))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Features',
                        style: subheading,
                      ),

                      SizedBox(
                        height:60,
                        width: double.infinity,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 3),
                          itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              extraIndex +=2;
                              mystr = feature[extraIndex].toString();
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color:grey,
                            ),
                            margin: EdgeInsets.only(right: 7),
                            child: Container(
                              padding:EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(featureIcon[index],color: greenTheme,),
                                  Text("  "+feature[extraIndex+1].toString()+" "+mystr[0].toUpperCase()+mystr.substring(1).toLowerCase(),style: text,),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Location & Nearby Facilities',
                        style: subheading,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height:60,
                        width: double.infinity,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 3),
                          itemCount: 7,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color:grey,
                            ),
                            margin: EdgeInsets.only(right: 7),
                            child: Container(
                              padding:EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(facilitiesKey[index].toString(),style: text,),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Center(
                        child:Image.asset('assets/images/propDetailMap.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Cost of Living',
                        style: subheading,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 30),
                              width: screenWidth*0.8,
                              height: 85,
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: grey),
                           child:Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               RichText(text: TextSpan(text: '₹ 30k ',style: boldText,children: [
                                 TextSpan(text: "/month",style:text),
                               ]),
                               ),
                               Text('From average citizen spend around this location',style:text,),
                             ],
                             ),
                           ),
                          ),
                      SizedBox(
                        height: screenHeight*0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
