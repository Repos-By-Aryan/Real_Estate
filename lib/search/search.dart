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

  // Function to build the content based on selectedCard
  Widget buildContent() {
    switch (selectedCard) {
      case 0:
        return Text(
          'Property Type',
          style: subheading,
        );
      default:
        return Container(); // You can return a different widget for other cases
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        title: Text('Filters', style: heading),
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
            child: TextButton(
              onPressed: () {
                setState(() {
                });
              },
              child: Text(
                "Reset",
                style: boldText,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Color textColor =
                        index == selectedCard ? Colors.white : Colors.black;
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
            SizedBox(
              height: 15,
            ),
            buildContent(),
          ],
        ),

      ),
    );
  }
}
