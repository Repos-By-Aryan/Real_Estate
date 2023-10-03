
import 'package:flutter/material.dart';

var heading = TextStyle(fontWeight: FontWeight.w900,fontSize: 23);
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
        color: Color(0xffedf4ff),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logo,width: 40,height:30),
            SizedBox(width: 10,),
            Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
