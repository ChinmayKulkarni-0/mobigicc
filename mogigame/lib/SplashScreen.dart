import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:mogigame/RCvier.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 void initState() {
    //set time to load the new page
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Lottie.network('https://assets4.lottiefiles.com/packages/lf20_1pxqjqps.json')),
            const SizedBox(height: 20),
           DefaultTextStyle(
  style: const TextStyle(
    fontSize: 20.0,
  ),
  child: AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText('Welcome to Mobigic',textStyle: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 1,
      wordSpacing: 1
      )),
    ],
  ),)])
      ),
    );
  }
}