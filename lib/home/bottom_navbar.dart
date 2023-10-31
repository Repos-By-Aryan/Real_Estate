import 'package:flutter/material.dart';
import 'package:real_estate/search/search.dart';
import 'package:real_estate/routes/routes_name.dart';

import '../constants/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_screen.dart';
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}


int currentIndex =0;
class _BottomNavBarState extends State<BottomNavBar> {
final screens = [
   HomeScreen(),
   Search(),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(children: screens),
      bottomNavigationBar: Container(
        color:navbarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
          child: GNav(
              gap: 8,
              backgroundColor: navbarColor,
              color:theme,
              activeColor: theme,
              rippleColor: const Color(0x2b234f68),
              tabBackgroundColor: const Color(0x1a234f68),
              padding: const EdgeInsets.all(16),
              onTabChange: (index){
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: [
                GButton(icon: Icons.home,
                  text:"Home",active: currentIndex==0,),
                GButton(icon: Icons.search,
                  text:"Search",
                  active: currentIndex == 1,),
                GButton(icon: Icons.favorite_border,
                  text:"Likes",active: currentIndex == 2,),
                GButton(icon: Icons.account_circle,
                  text:"Account",active: currentIndex == 3,),
              ]
          ),
        ),
      ),
    );
  }
}
