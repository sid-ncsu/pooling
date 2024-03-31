import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    // Get the current user when the widget initializes
    _currentUser = FirebaseAuth.instance.currentUser!;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is Page 2!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome,',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              _currentUser.displayName ?? 'User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}