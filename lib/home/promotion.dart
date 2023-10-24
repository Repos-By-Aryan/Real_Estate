import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../routes/routes_name.dart';

class Promotion extends StatelessWidget {
  const Promotion({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight:80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffF5F4F8),
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
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF5F4F8),
                elevation: 0.2,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
              child: const Icon(
                Icons.file_upload_outlined,
                size: 25,
                color: Colors.black87,
              ),
            ),
          ),],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ],
      ),
    );
  }
}
