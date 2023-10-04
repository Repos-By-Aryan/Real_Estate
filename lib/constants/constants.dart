
import 'package:flutter/material.dart';
final Color grey = Color(0x71adb9d3);

var heading = TextStyle(fontWeight: FontWeight.w900,fontSize: 23,color: Colors.black);
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
      height: 50,
      child: Center(child: Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
    );
  }
}
