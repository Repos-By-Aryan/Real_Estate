import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

DateTime now = DateTime.now();
String month = DateFormat('MMMM').format(now);

class Promotion extends StatelessWidget {
  const Promotion({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
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
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF5F4F8),
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
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 210,
                  width: screenWidth * 0.9,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: screenWidth * 0.8,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/one.webp'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Text("Festive", style: saleTextStyle),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: Text("Sale!", style: saleTextStyle),
                      ),
                      const Positioned(
                        top: 90,
                        left: 20,
                        child: Text(
                          "All discounts upto 60%",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 7,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff234F68),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 7),
                            child: Center(
                                child: Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                              size: 30,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                maxLines: 3,
                textAlign: TextAlign.start,
                text: const TextSpan(
                    text: "Limited Time ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        fontFamily: 'Lato',
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Festive\nSale",
                        style: TextStyle(
                          color: Color(0xff234F68),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato',
                        ),
                      ),
                      TextSpan(
                          text: " is coming back! ",
                          style: TextStyle(fontSize: 30, color: Colors.black)),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/calender.svg',
                    width: 15,
                    height: 15,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$month ${now.day}, ${now.year}",
                    style: text,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0x4d8bc83f),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: const Color(0xff8bc83f),
                            borderRadius: BorderRadius.circular(17)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            'assets/svg/ticket.svg',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HLWN40',
                              style: subheading,
                            ),
                            Text(
                              'Use this coupon to get 40% of on\nyour transaction',
                              style: ratingStyle,
                              maxLines: 2,
                              softWrap: true,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextWrapper(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores',),
            ],
          ),
        ),
      ),
    );
  }
}
class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}): super(key: key);
  final String text;
  @override
  State<TextWrapper> createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper> with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: ConstrainedBox(
                  constraints: isExpanded ? const BoxConstraints(): const BoxConstraints(maxHeight: 70),
                  child: Text(
                    widget.text,
                    style: const TextStyle(fontSize: 16),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )
              )
          ),
          isExpanded ? OutlinedButton.icon(
              icon: const Icon(Icons.arrow_upward),
              label: const Text('Read less'),
              onPressed: () => setState(() => isExpanded = false)
          ) : TextButton.icon(
              icon: const Icon(Icons.arrow_downward),
              label: const Text('Read more'),
              onPressed: () => setState(() => isExpanded = true)
          )
        ]
    );
  }
}

