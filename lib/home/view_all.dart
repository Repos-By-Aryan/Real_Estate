import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
import '../routes/routes_name.dart';

class ViewAll extends StatefulWidget {
  dynamic data;
   ViewAll({super.key,this.data});

  @override
  State<ViewAll> createState() => _ViewAllState();
}
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

class _ViewAllState extends State<ViewAll> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final firestore =
    FirebaseFirestore.instance.collection('listings').snapshots();

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/viewAll.png',fit: BoxFit.fitWidth,),
              Positioned(
                top:40,
                child: ElevatedButton(
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
              ),
            ],
          ),
          SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data['name'],style: subheading,),
                SizedBox(height: 10,),
                StreamBuilder(
                stream: firestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  final houseFilter = snapshot.data!.docs
                      .where((document) => document['category'] == 'House')
                      .toList();
                  final villaFilter = snapshot.data!.docs
                      .where((document) => document['category'] == 'Villa')
                      .toList();
                  final apartmentFilter = snapshot.data!.docs
                      .where(
                          (document) => document['category'] == 'Apartment')
                      .toList();

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("An error occurred."));
                  }
                  return SizedBox(
                    height: screenHeight * 0.3,
                    width: screenWidth,
                    child: GridView.builder(
                      gridDelegate:
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        maxCrossAxisExtent: screenWidth * 0.5,
                        mainAxisExtent: 245,
                        // crossAxisCount: 2, // Set the number of columns here
                      ),
                      itemCount: snapshot.data!.docs.length < 10
                          ? snapshot.data!.docs.length
                          : 10,
                      itemBuilder: (context, index) {
                        final document = snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(
                              context,
                              RoutesName.propertyDetail,
                              arguments: {
                                'id': document.id,
                              },
                            );
                          },
                          child: Container(
                            constraints: const BoxConstraints.expand(),
                            // margin: const EdgeInsets.only(bottom: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF5F4F8),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: document['image_urls'][0]
                                            .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: double.infinity,
                                                height: 170,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                        placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                        errorWidget:
                                            (context, url, error) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 18,
                                      right: 18,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xb0234f68),
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 4),
                                          child: RichText(
                                            text: TextSpan(
                                                text: document['type']
                                                ['rent']
                                                    ? "₹ ${formatValue(document['price']['rent']['monthly'])}"
                                                    : "₹ ${formatValue(document['price']['sell'])}",
                                                style: const TextStyle(
                                                  fontFamily: 'Lato',
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: document['type']
                                                    ['rent']
                                                        ? " /month"
                                                        : "",
                                                    style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 6,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document['title'],
                                          style: featuredTitle,
                                          maxLines: 1,
                                          softWrap: true,
                                        ),
                                        Row(
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
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 4),
                                              child: Text(
                                                  document['rating']
                                                      .toString(),
                                                  style: ratingStyle),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 6),
                                              child: SizedBox(
                                                child: SvgPicture.asset(
                                                  'assets/svg/location.svg',
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 4),
                                              child: Text(
                                                document['address']['city']
                                                    .toString(),
                                                style: ratingStyle,
                                                softWrap: true,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );

                },
              ),
                SizedBox(height: screenHeight*0.1,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

