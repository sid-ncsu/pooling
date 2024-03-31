import 'package:flutter/material.dart';
import 'package:pooling/DestinationSearch.dart';
import './postride.dart';
import 'package:firebase_auth/firebase_auth.dart';



class RideOptionScreen extends StatelessWidget {
  // late User _currentUser;

  // @override
  // void initState() {
  //   // Get the current user when the widget initializes
  //   super.initState();
  //   _currentUser = FirebaseAuth.instance.currentUser!;
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Option'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Text(
          //     _currentUser.displayName ?? 'User',
          //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //   ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'How can we help you today?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          OptionCard(
            icon: Icons.directions_car,
            text: 'Find me a ride!',
            onTap: () {
              Navigator.push(
                  context,
                MaterialPageRoute(builder: (context) => DestinationSearch()),
    );
  },
          ),
          OptionCard(
            icon: Icons.note_add,
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
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  OptionCard({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40.0),
              SizedBox(width: 24.0),
              Text(
                text,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}