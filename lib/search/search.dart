import 'package:flutter/material.dart';

import '../constants/constants.dart';

enum TenantsPreferred { Bachelor, Family }

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

int selectedCard = 0;
final filters = ['Buy', 'Rent'];
final propertyType = ['House', 'Apartment', 'Villa'];
final bedrooms = ['1 BHK', '2 BHK', '3 BHK', '4 BHK', '>4 BHK'];
final icons = [
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
  ),
];

class _SearchState extends State<Search> {
  List<bool> propertTypeIsChecked = [true, false, false];
  List<bool> bedroomIsChecked = [false, false, false, false, true];
  TenantsPreferred? _tenantsPreferred;

  // Common method to build property type container
  Widget buildPropertyTypeContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      width: 100,
      child: GestureDetector(
        onTap: () {
          setState(() {
            propertTypeIsChecked[index] = !propertTypeIsChecked[index];
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: propertTypeIsChecked[index]
                ? Color(0x234F68B0)
                : Colors.transparent,
            border: Border.all(
              width: 0.2,
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
  }

  // Common method to build dropdown button for budget
  Widget buildBudgetDropdown(String label) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: DropdownButtonFormField<String>(
        isDense: true,
        menuMaxHeight: 450,
        decoration: InputDecoration(
          prefix: Text('₹ '),
          filled: false,
          fillColor: Color(0xA4F68B0),
          labelText: label,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        borderRadius: BorderRadius.circular(20),
        focusColor: theme,
        hint: Text(label),
        items: [
          '5 Lac',
          '10 Lac',
          '20 Lac',
          '30 Lac',
          '40 Lac',
          '50 Lac',
          '60 Lac',
          '70 Lac',
          '80 Lac',
          '90 Lac',
          '1 Cr',
          '1.2 Cr',
          '1.4 Cr',
          '1.6 Cr',
          '1.8 Cr',
          '2 Cr',
          '2.3 Cr',
          '2.6 Cr',
          '3 Cr',
          '3.5 Cr',
          '4 Cr',
          '4.5 Cr',
          '5 Cr',
          '10 Cr',
          '15 Cr'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // Handle the value change
        },
      ),
    );
  }

  // Common method to build bedrooms container
  Widget buildBedroomsContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      width: 100,
      child: GestureDetector(
        onTap: () {
          setState(() {
            bedroomIsChecked[index] = !bedroomIsChecked[index];
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bedroomIsChecked[index]
                  ? Color(0x234F68B0)
                  : Colors.transparent,
              border: Border.all(
                width: 0.2,
                color: Colors.black,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  bedrooms[index],
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
  }

  // Common method to build tenants preferred container
  Widget buildTenantsPreferredContainer(TenantsPreferred value, String name) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tenantsPreferred = value;
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _tenantsPreferred == value ? Color(0x234F68B0) : Colors.transparent,
            border: Border.all(
              width: 0.2,
              color: Colors.black,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Common method to build filter cards
  Widget buildFilterCard(int index) {
    Color cardColor =
    index == selectedCard ? const Color(0xff234F68) : Colors.white;
    Color textColor = index == selectedCard ? Colors.white : Colors.black;
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          child: Center(child: Text(filters[index], style: TextStyle(color: textColor))),
        ),
      ),
    );
  }

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
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: propertyType.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildPropertyTypeContainer(index);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Budget',
                  style: subheading,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildBudgetDropdown('Min'),
                    buildBudgetDropdown('Max'),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Bedrooms',
                  style: subheading,
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: bedrooms.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildBedroomsContainer(index);
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      case 1:
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
                SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: propertyType.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildPropertyTypeContainer(index);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Budget',
                  style: subheading,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildBudgetDropdown('Min'),
                    buildBudgetDropdown('Max'),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Bedrooms',
                  style: subheading,
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  child: ListView.builder(
                    itemCount: bedrooms.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildBedroomsContainer(index);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Tenants Preferred',
                  style: subheading,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTenantsPreferredContainer(
                        TenantsPreferred.Bachelor, TenantsPreferred.Bachelor.name),
                    SizedBox(width: 10),
                    buildTenantsPreferredContainer(
                        TenantsPreferred.Family, TenantsPreferred.Family.name),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      default:
        return Center(child: Text("Something went wrong"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 55,
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
                  propertTypeIsChecked = [true, false, false];
                  bedroomIsChecked = [false, false, false, false, true];
                  _tenantsPreferred=null;
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
                  return buildFilterCard(index);
                },
              ),
            ),
            SizedBox(height: 15),
            buildContent(screenWidth, screenHeight),
            Align(
              alignment:Alignment.bottomCenter,
              child:InkWell(
                onTap: (){

                },
                child: Container(
                  width: screenWidth*0.65,
                  height:50,
                  decoration: BoxDecoration(
                    color: greenTheme,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child:Text("Apply",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                  ),
                ),),
            )
          ],
        ),
      ),
    );
  }
}
