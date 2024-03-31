import 'package:flutter/material.dart';

// Define a new stateful widget
class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

// Define the state associated with the stateful widget
class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    // Return a widget that represents the stateful widget's UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: const Center(
        child: Text(
          'This is Page 2!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
