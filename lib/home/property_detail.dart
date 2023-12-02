import 'package:banner_carousel/banner_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';
bool active = false;

class PropertyDetail extends StatefulWidget {
  final data;
  const PropertyDetail({super.key,required this.data});

  @override
  State<PropertyDetail> createState() => _PropertyDetailState();
}
int currentIndex= 0;
List imageUrls =[];


class _PropertyDetailState extends State<PropertyDetail> {

  @override
  void initState() {
    super.initState();
    fetchImageUrls();

  }

  Future<void> fetchImageUrls() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance.collection('listings').doc(widget.data['id']).get();

      if (documentSnapshot.exists) {
        setState(() {
          imageUrls = List<String>.from(documentSnapshot['image_urls']);
        });
        print(imageUrls);
      }
      else{
        print('else');
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final firestore =
    FirebaseFirestore.instance.collection('listings').snapshots();

    List<BannerModel> bannerImage = [
      BannerModel(imagePath: 'assets/images/heart.png', id: "1"),
      BannerModel(imagePath: 'assets/images/map.png', id: "2"),

    ];
    // final property = FirebaseFirestore.instance.collection('listings').doc(widget.data['id']);

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
                  BannerCarousel.fullScreen(
                    banners: bannerImage,
                    customizedIndicators: IndicatorModel.animation(width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                    height:screenHeight*0.5,
                    activeColor: theme,
                    disableColor: Colors.white,
                    animation: true,
                    borderRadius: 10,
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
                            setState(() {
                              active=!active;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: active?const Color(0xff8ac73f):const Color(0xcbffffff),
                            elevation: 0.2,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: active?SvgPicture.asset('assets/svg/heart_w.svg',width: 25,):Image.asset('assets/images/heart.png',width: 25),
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
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 6,
                        ),
                        child: Text(
                          'Apartment',
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
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 6,
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
                                "4.9",
                                style:const TextStyle(
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

              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

