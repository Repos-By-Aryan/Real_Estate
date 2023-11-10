import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

int selectedCard = 0;
final filters = ['Buy', 'Rent'];
final propertyType = ['House', 'Apartment', 'Villa'];
final icons = <Widget>[
  Icon(
    Icons.home_outlined,
    size: 30,
    color: theme,
  ),
  Icon(
    Icons.apartment_outlined,
    size: 30,
    color: theme,
  ),
  Icon(
    Icons.villa,
    size: 30,
    color: theme,
  )
];

class _SearchState extends State<Search> {
  // Function to build the content based on selectedCard
    List<bool> isChecked = [false, false, false];
  Widget buildContent(final screenWidth, final screenHeight) {

    switch (selectedCard) {
      case 0:
        return Expanded(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Property Type',
                  style: subheading,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 7),
                        width: 100,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isChecked[index] = !isChecked[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12 ),
                              color: isChecked[index] ? Color(0x234F68B0):Colors.transparent,
                              border: Border.all(
                                width:0.2,
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  icons[index],
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    propertyType[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Budget',
                  style: subheading,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: screenWidth*0.4,
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 250,
                        decoration: InputDecoration(
                          prefix: Text('₹ '),
                          filled: false,
                          fillColor:  Color(0xA4F68B0),
                          labelText: 'Min',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        focusColor: theme,
                        hint: Text('₹ Min'),
                        items: ['5 Lac', '10 Lac', '15 Lac','20 Lac'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the value change
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth*0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 250,
                        decoration: InputDecoration(
                          prefix: Text('₹ '),
                          filled: true,
                          fillColor:  Color(0xA4F68B0),
                          labelText: 'Max',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                        focusColor: theme,
                        hint: Text('₹ Max'),
                        items: ['10 Lac', '20 Lac', '30 Lac','40 Lac','50 Lac'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the value change
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      default:
        return Container();
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
                setState(() {});
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
            buildContent(screenWidth,screenHeight),
          ],
        ),
      ),
    );
  }
}
