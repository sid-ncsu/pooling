import 'package:flutter/material.dart';
import './AvailableRidesPage.dart';
// Define a new stateful widget

class DestinationSearch extends StatefulWidget {
  const DestinationSearch({Key? key}) : super(key: key);

  @override
  _DestinationSearchState createState() => _DestinationSearchState();
}

// Define the state associated with the stateful widget
class _DestinationSearchState extends State<DestinationSearch> {
  @override
  Widget build(BuildContext context) {
    // Return a widget that represents the stateful widget's UI
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Where would you like to go?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your destination here',
                border: OutlineInputBorder(),
              ),
            ),
          ),
           ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AvailableRidesPage(),
                ));
              },
              child: Text('Search'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, 
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          SizedBox(height: 50.0),
          Expanded(
            child: Image.asset('images/destination.png'), // Replace with your image asset
          ),
        ],
      ),
    );
  }
}
