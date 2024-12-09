// ignore_for_file: use_super_parameters, file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:exam_store/backend_auth/firebase_ui.dart';
import 'package:flutter/material.dart';
import 'package:tbib_splash_screen/splash_screen.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> with SingleTickerProviderStateMixin {
  bool isLoaded = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        isLoaded = true;
      });
      _controller.dispose();
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      duration: const Duration(seconds: 1),
      navigateWhere: isLoaded,
      navigateRoute: const myapping(), 
      backgroundColor: Colors.white,
      text: WavyAnimatedText(
        "LOADING",
        textAlign: TextAlign.center,
        textStyle: const TextStyle(
          color: Colors.red,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: null,
      displayLoading: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}