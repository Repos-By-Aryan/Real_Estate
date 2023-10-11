// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    bool isCardSelected = false;

    return Container(
      width: screenWidth,
      height: screenHeight,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/Homebackdrop.png')),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              horizontal: 12.0, vertical: 8),
                          child: DropdownButton(
                              iconSize: 25,
                              items: [
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
                              size: 30,
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
                              size: 30,
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
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xffF5F4F8),
                            borderRadius: BorderRadius.circular(
                                12), // Adjust the border radius as needed// Add a border color
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Icon(Icons.search, color: Colors.black),
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Search Apartment, House, etc.",
                                    border: InputBorder
                                        .none, // Remove the input border
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Icon(Icons.mic_none_outlined,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          Color cardColor =
                              index == 0 ? Color(0xff234F68) : Colors.white;
                          Color textColor =
                              index == 0 ? Colors.white : Colors.black;
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 7),
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
                                  child: Text('All',
                                      style: TextStyle(color: textColor))),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
// child:Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: SearchAnchor(
// builder: (BuildContext context, SearchController controller) {
// return Container(
// constraints: BoxConstraints.tightForFinite(),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// color: Color(0xffF5F4F8),// Adjust the border radius as needed
// border: Border.all(
// color: Colors.grey, // Add a border color
// ),
// ),
// child: SearchBar(
// controller: controller,
// padding: const MaterialStatePropertyAll<EdgeInsets>(
// EdgeInsets.symmetric(horizontal: 16.0,vertical: 12)),
// onTap: () {
// controller.openView();
// },
// onChanged: (_) {
// controller.openView();
// },
// leading: const Icon(Icons.search),
// trailing: <Widget>[
// Text("|"),
// SizedBox(width:5),
// Icon(Icons.mic_none_outlined)
// ],
// ),
// );
// }, suggestionsBuilder:
// (BuildContext context, SearchController controller) {
// return List<ListTile>.generate(5, (int index) {
// final String item = 'item $index';
// return ListTile(
// title: Text(item),
// onTap: () {
// setState(() {
// controller.closeView(item);
// });
// },
// );
// });
// }),
// ),
// ),
