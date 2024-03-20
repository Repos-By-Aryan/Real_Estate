import 'package:flutter/material.dart';
import 'package:real_estate/routes/routes_name.dart';
import 'package:real_estate/splash_services/splash_services.dart';
import 'package:video_player/video_player.dart';

var splashService = SplashServices();

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  SplashServices _splashServices = SplashServices();

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
    _splashServices.isLogin(context);
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
