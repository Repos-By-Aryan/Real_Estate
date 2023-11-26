

import 'package:flutter/material.dart';
const Color theme = Color(0xff234F68);
const Color navbarColor = Color(0xe5ffffff);
const Color grey = Color(0xffF5F4F8);
var saleTextStyle = const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: Colors.white, fontSize: 30,);
var heading = const TextStyle(fontFamily:'Lato',fontWeight: FontWeight.w900,fontSize: 23,color: Colors.black);
var subheading = const TextStyle(fontFamily:'Lato',fontWeight: FontWeight.w700,fontSize: 23,color:theme );
var text = const TextStyle(fontFamily:'Lato',color:theme,fontSize: 12);
var boldText = const TextStyle(fontFamily:'Lato',color:theme,fontSize: 18,fontWeight: FontWeight.w700);
var featuredTitle = const TextStyle(fontFamily: 'Lato',color: Color(0xFF252B5C),fontSize: 20,fontWeight: FontWeight.w700);
var ratingStyle = const TextStyle(
  fontSize: 12,  fontWeight: FontWeight.w700, color: Color(0xff53587A),fontFamily: 'Lato',);


class SignInButton extends StatelessWidget {
  final String title;
  final String logo;
  final double width;
  final double height;
  const SignInButton({super.key,required this.title,required this.logo, this.width = 200,this.height=45});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height:height,
      decoration: BoxDecoration(
        color: const Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logo,width: 40,height:40),
            const SizedBox(width: 10,),
            Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  const RoundedButton({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 45,
      child: Center(child: Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
    );
  }
}
