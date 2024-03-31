import 'package:flutter/material.dart';
import 'package:pooling/DestinationSearch.dart';
import './PostRide.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RideOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Logged In Successfully'),
        centerTitle: true, // Center the title if you prefer
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (currentUser != null)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Welcome, ${currentUser.displayName}!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                   color: Color(0xFFF930204), 
                   backgroundColor: Colors.white,// Here's the color change for the text
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'How can we help you today?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF930204), 
                backgroundColor: Colors.white,
                // Here's the color change for the text
              ),
              textAlign: TextAlign.center,
            ),
          ),
          OptionCard(
            imagePath: 'images/findme.png',
            text: 'Find me a ride!',
            
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DestinationSearch()),
              );
            },
          ),
          OptionCard(
            imagePath: 'images/postnew.png',
            text: 'Post my ride!',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => postride()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const OptionCard({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                height: 120.0,
                width: 120.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFFF930204), 
                  backgroundColor: Colors.white,// Text color for the option cards
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
