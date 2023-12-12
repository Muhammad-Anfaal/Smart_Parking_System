import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/log_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 100, // Adjust the height as needed
            ),
            const SizedBox(height: 6), // Added spacing between image and text
            AnimatedText(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      nextScreen: LogInPage(),
      splashIconSize: 250,
      duration: 4000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({Key? key}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  late double _opacity;

  @override
  void initState() {
    super.initState();
    _opacity = 0.0;

    // Add delay and animate the text after the logo animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0.0, end: _opacity),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Text(
            'Smart Parking System',
            style: GoogleFonts.dancingScript(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
