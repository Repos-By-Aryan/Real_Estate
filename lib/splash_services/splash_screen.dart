import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:real_estate/auth/login.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/Splash.mp4')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo()async{
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }
}

// child: Lottie.network(
//     "https://lottie.host/d948f6e8-a420-4793-818a-7db0eff1e61b/pS6E5OaiTA.json",
//     width: 200 ,
//     height:200,
//     fit: BoxFit.cover,
//   repeat: true,
// ),
