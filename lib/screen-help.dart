import 'package:flutter/material.dart';

class FindRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find a Ride')),
      body: Center(
        child: Text('Here you can search for available rides.'),
      ),
    );
  }
}

class PostRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post a Ride')),
      body: Center(
        child: Text('Here you can post details about a ride you are offering.'),
      ),
    );
  }
}


class RideOptionScreen extends StatelessWidget {
  void _findRide(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FindRideScreen()));
  }

  void _postRide(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostRideScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Choose Your Option'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
            onTap: () => _findRide(context),
          ),
          OptionCard(
            icon: Icons.note_add,
            text: 'Post my ride!',
            onTap: () => _postRide(context),
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
