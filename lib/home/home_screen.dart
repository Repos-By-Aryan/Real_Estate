//HomeScreen Code
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/search/search.dart';
import 'package:real_estate/routes/routes_name.dart';


class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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


  int currentIndex =0;
  int selectedCard = 0;
  final filters = ['All', 'House', 'Apartment', 'Villa'];


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
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/Homebackdrop.png')),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset.fromDirection(120, 3.0),
                              blurRadius: 4)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6),
                        child: DropdownButton(
                            iconSize: 25,
                            items: const [
                              DropdownMenuItem(
                                  child: Text('New Delhi, India')),
                            ],
                            onChanged: (value) {}),
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: const Icon(
                            Icons.notifications,
                            size: 25,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 5,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            size: 25,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                RichText(
                  maxLines: 3,
                  text: const TextSpan(
                      text: "Hey, ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          fontFamily: 'Lato',
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Guest!\n",
                          style: TextStyle(
                            color: Color(0xff234F68),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Lato',
                          ),
                        ),
                        TextSpan(
                            text: "Let's start exploring ",
                            style:
                            TextStyle(fontSize: 30, color: Colors.black)),
                      ]),
                ),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.search);
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F4F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Icon(Icons.search, color: Colors.black),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Text('Search Apartment, House, etc.')
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Icon(Icons.mic_none_outlined, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        Color cardColor = index == selectedCard
                            ? const Color(0xff234F68)
                            : Colors.white;
                        Color textColor = index == selectedCard
                            ? Colors.white
                            : Colors.black;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCard = index;
                            });
                          },
                          child: Card(
                            margin: const EdgeInsets.only(right: 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            color: cardColor,
                            shadowColor: cardColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              child: Center(
                                  child: Text(filters[index],
                                      style: TextStyle(color: textColor))),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.promotion);
                  },
                  child: SizedBox(
                    height: 170,
                    width: screenWidth,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 7),
                                width: screenWidth * 0.8,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                      AssetImage('assets/images/one.webp'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Text("Festive", style: saleTextStyle),
                              ),
                              Positioned(
                                top: 50,
                                left: 20,
                                child: Text("Sale!", style: saleTextStyle),
                              ),
                              const Positioned(
                                top: 90,
                                left: 20,
                                child: Text(
                                  "All discounts upto 60%",
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 7,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xff234F68),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(18),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 7),
                                    child: Center(
                                        child: Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured Estates',
                      style: subheading,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('View all', style: text)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: firestore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Text("An error occurred.");
                      }
                      return SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length < 4
                                ? snapshot.data!.docs.length
                                : 4,
                            itemBuilder: (context, index) {
                              final document = snapshot.data!.docs[index];
                              final propertyType = document['type'];
                              if (propertyType['rent']) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  constraints: BoxConstraints.expand(
                                      height: 160, width: screenWidth * 0.82),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffF5F4F8),
                                  ),
                                  child: Row(
                                    children: [
                                      Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: document['image_urls']
                                              [0]
                                                  .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: (screenWidth * 0.8) *
                                                          0.49,
                                                      height:
                                                      160, // Add height constraint
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                            left: 18,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                const Color(0xff234F68),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 4),
                                                child: Text(
                                                  document['category'],
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 18,
                                            left: 18,
                                            child: SizedBox(
                                              width: 23,
                                              height: 23,
                                              child: ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  Colors.white,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        30),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: SvgPicture.asset(
                                                  'assets/svg/heart.svg',
                                                  width: 25,
                                                  height: 25,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: (screenWidth * 0.8) *
                                            0.48, // Wrap the Text widget with Expanded
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(vertical: 8.0),
                                                child: Text(
                                                  document['title'],
                                                  style: featuredTitle,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                ),
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
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: SvgPicture.asset(
                                                        'assets/svg/location.svg',
                                                        width: 20,
                                                        height: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(left: 4),
                                                      child: Text(
                                                        document['address']
                                                        ['city']
                                                            .toString(),
                                                        style: ratingStyle,
                                                        softWrap: true,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 10.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: ('Rs. ${formatValue(document[
                                                          'price']
                                                          ['rent']
                                                          ['monthly']
                                                              .toDouble())}'),
                                                      style: boldText,
                                                      children: [
                                                        TextSpan(
                                                            text: "/month",
                                                            style: text),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (propertyType['sell']) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  constraints: BoxConstraints.expand(
                                      height: 160, width: screenWidth * 0.82),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffF5F4F8),
                                  ),
                                  child: Row(
                                    children: [
                                      Stack(
                                        fit: StackFit.passthrough,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl: document['image_urls']
                                              [0]
                                                  .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: (screenWidth * 0.8) *
                                                          0.49,
                                                      height:
                                                      160, // Add height constraint
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                            left: 18,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                const Color(0xff234F68),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 4),
                                                child: Text(
                                                  document['category'],
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 18,
                                            left: 18,
                                            child: SizedBox(
                                              width: 23,
                                              height: 23,
                                              child: ElevatedButton(
                                                style:
                                                ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  Colors.white,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        30),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: SvgPicture.asset(
                                                  'assets/svg/heart.svg',
                                                  width: 25,
                                                  height: 25,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: (screenWidth * 0.8) *
                                            0.48, // Wrap the Text widget with Expanded
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(vertical: 8.0),
                                                child: Text(
                                                  document['title'],
                                                  style: featuredTitle,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                ),
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
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: SvgPicture.asset(
                                                        'assets/svg/location.svg',
                                                        width: 20,
                                                        height: 20,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(left: 4),
                                                      child: Text(
                                                        document['address']
                                                        ['city']
                                                            .toString(),
                                                        style: ratingStyle,
                                                        softWrap: true,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 10.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: ('Rs. ${formatValue(document[
                                                          'price']
                                                          ['sell']
                                                              .toDouble())}'),
                                                      style: boldText,
                                                      children: const [
                                                        // TextSpan(text:"/month",style: text),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return null;
                            }),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Estates',
                      style: subheading,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('View all', style: text)),
                  ],
                ),
                StreamBuilder(
                  stream: firestore,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    final houseFilter = snapshot.data!.docs
                        .where((document) => document['category'] == 'House')
                        .toList();
                    final villaFilter = snapshot.data!.docs
                        .where((document) => document['category'] == 'Villa')
                        .toList();
                    final apartmentFilter = snapshot.data!.docs.where((document) => document['category'] == 'Apartment').toList();

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("An error occurred."));
                    }

                    switch(selectedCard){
                      case 0 : return SizedBox(
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            maxCrossAxisExtent: screenWidth*0.5,
                            mainAxisExtent:245,
                            // crossAxisCount: 2, // Set the number of columns here
                          ),
                          itemCount: snapshot.data!.docs.length < 10 ? snapshot.data!.docs.length : 10,
                          itemBuilder: (context, index) {
                            final document = snapshot.data!.docs[index];
                            return Container(
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
                                          imageUrl: document['image_urls'][0].toString(),
                                          imageBuilder: (context, imageProvider) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: double.infinity,
                                              height: 170,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 18,
                                        right: 18,
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: const Color(0xb0234f68),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                            child: RichText(
                                              text:TextSpan(text:document['type']['rent']?"₹ ${formatValue(document['price']['rent']['monthly'])}":"₹ ${formatValue(document['price']['sell'])}",
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(text:document['type']['rent']?" /month":"",style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 6,
                                                    ),),
                                                  ]
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        right: 18,
                                        child: SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: SvgPicture.asset(
                                              'assets/svg/heart.svg',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                                      child:  Column(
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                    document['rating']
                                                        .toString(),
                                                    style: ratingStyle),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(left: 6),
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                  document['address']
                                                  ['city']
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
                            );
                          },
                        ),
                      );
                      case 1 : return SizedBox(
                        height: screenHeight * 0.5,
                        width: screenWidth,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            maxCrossAxisExtent: screenWidth*0.5,
                            mainAxisExtent:245,
                            // crossAxisCount: 2, // Set the number of columns here
                          ),
                          itemCount: houseFilter.length < 10 ? houseFilter.length : 10,
                          itemBuilder: (context, index) {
                            final document = houseFilter[index];

                            return Container(
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
                                          imageUrl: document['image_urls'][0].toString(),
                                          imageBuilder: (context, imageProvider) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: double.infinity,
                                              height: 170,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 18,
                                        right: 18,
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: const Color(0xb0234f68),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                            child: RichText(
                                              text:TextSpan(text:document['type']['rent']?"₹ ${formatValue(document['price']['rent']['monthly'])}":"₹ ${formatValue(document['price']['sell'])}",
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(text:document['type']['rent']?" /month":"",style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 6,
                                                    ),),
                                                  ]
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        right: 18,
                                        child: SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: SvgPicture.asset(
                                              'assets/svg/heart.svg',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                                      child:  Column(
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                    document['rating']
                                                        .toString(),
                                                    style: ratingStyle),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(left: 6),
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                  document['address']
                                                  ['city']
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
                            );
                          },
                        ),
                      );
                      case 2: return SizedBox(
                        height: screenHeight * 0.5,
                        width: screenWidth,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            maxCrossAxisExtent: screenWidth*0.5,
                            mainAxisExtent:245,
                            // crossAxisCount: 2, // Set the number of columns here
                          ),
                          itemCount: apartmentFilter.length < 10 ? apartmentFilter.length : 10,
                          itemBuilder: (context, index) {
                            final document = apartmentFilter[index];

                            return Container(
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
                                          imageUrl: document['image_urls'][0].toString(),
                                          imageBuilder: (context, imageProvider) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: double.infinity,
                                              height: 170,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 18,
                                        right: 18,
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: const Color(0xb0234f68),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                            child: RichText(
                                              text:TextSpan(text:document['type']['rent']?"₹ ${formatValue(document['price']['rent']['monthly'])}":"₹ ${formatValue(document['price']['sell'])}",
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(text:document['type']['rent']?" /month":"",style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 6,
                                                    ),),
                                                  ]
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        right: 18,
                                        child: SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: SvgPicture.asset(
                                              'assets/svg/heart.svg',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                                      child:  Column(
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                    document['rating']
                                                        .toString(),
                                                    style: ratingStyle),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(left: 6),
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                  document['address']
                                                  ['city']
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
                            );
                          },
                        ),
                      );
                      case 3: return SizedBox(
                        height: screenHeight * 0.5,
                        width: screenWidth,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            maxCrossAxisExtent: screenWidth*0.5,
                            mainAxisExtent:245,
                            // crossAxisCount: 2, // Set the number of columns here
                          ),
                          itemCount: villaFilter.length < 10 ? villaFilter.length : 10,
                          itemBuilder: (context, index) {
                            final document = villaFilter[index];

                            return Container(
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
                                          imageUrl: document['image_urls'][0].toString(),
                                          imageBuilder: (context, imageProvider) => InkWell(
                                            onTap: () {},
                                            child: Container(
                                              width: double.infinity,
                                              height: 170,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 18,
                                        right: 18,
                                        child: Container(

                                          decoration: BoxDecoration(
                                            color: const Color(0xb0234f68),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                            child: RichText(
                                              text:TextSpan(text:document['type']['rent']?"₹ ${formatValue(document['price']['rent']['monthly'])}":"₹ ${formatValue(document['price']['sell'])}",
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(text:document['type']['rent']?" /month":"",style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 6,
                                                    ),),
                                                  ]
                                              ),),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 18,
                                        right: 18,
                                        child: SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: SvgPicture.asset(
                                              'assets/svg/heart.svg',
                                              width: 25,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0, bottom: 8),
                                      child:  Column(
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                    document['rating']
                                                        .toString(),
                                                    style: ratingStyle),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(left: 6),
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
                                                const EdgeInsets
                                                    .only(left: 4),
                                                child: Text(
                                                  document['address']
                                                  ['city']
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
                            );
                          },
                        ),
                      );
                      default:
                        return const Center(child: Text("No records found"));
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
