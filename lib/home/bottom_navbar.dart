import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({super.key});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

final
int currentIndex =0;
class _BottomNavigationBarState extends State<BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
