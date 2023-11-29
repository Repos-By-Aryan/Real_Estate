import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:real_estate/auth/login.dart';
import 'package:real_estate/constants/constants.dart';
import 'package:real_estate/home/home_screen.dart';
import 'package:real_estate/search/search.dart';

class MainScreen extends StatefulWidget {
  dynamic data;
  MainScreen({super.key,this.data});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
int currentIndex = 0;


class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(data: widget.data),
      Search(),
      Text("Screen 3"),
      Text("Screen 4"),
    ];
    return Scaffold(
      body:screens[currentIndex],
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
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              onTabChange: (index){
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: [
                GButton(icon: Icons.home,
                  text:"Home",active: currentIndex == 0,),
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
