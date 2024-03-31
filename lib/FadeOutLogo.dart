import 'dart:async';
import 'package:flutter/material.dart';
import './HomePage.dart'; // Make sure this import is correct

class FadeOutLogo extends StatefulWidget {
  @override
  _FadeOutLogoState createState() => _FadeOutLogoState();
}

class _FadeOutLogoState extends State<FadeOutLogo> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    // Start the fade out animation after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _startFadeOut());
  }

  void _startFadeOut() {
    // Change the opacity level to start the Fade out
    setState(() {
      _opacity = 0.0;
    });
    // After the specified duration navigate to the next page
    Timer(Duration(seconds: 2), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement( // Use pushReplacement to replace the current page in the navigation stack
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 3), // This is the duration of the fade out
          child: Column(
            mainAxisSize: MainAxisSize.min, // To center the logo and text vertically
            children: <Widget>[
              Image.asset('images/landingimage.png'), // Replace with your logo asset path
              SizedBox(height: 12), // You can adjust spacing between logo and text
              Text(
                'HowlRide', // Replace with your text
                style: TextStyle(
                  fontSize: 40, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                  color: Color(0xFFF930204), // Adjust the color as needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}