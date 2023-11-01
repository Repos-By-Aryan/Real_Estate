import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

int selectedCard = 0;
final filters = ['Buy', 'Rent'];


class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        title: Text('Filters',style:heading),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ElevatedButton(
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
              size: 25,
              color: Colors.black87,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(onPressed: (){}, child: Text("Reset",style: boldText,),),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              SizedBox(height: 15,),
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
    );
  }
}
