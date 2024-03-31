import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Available Rides',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AvailableRidesPage(),
    );
  }
}

class AvailableRidesPage extends StatelessWidget {
  final List<Map<String, dynamic>> rides = [
    {'name': 'Name', 'destination': 'Destination', 'date': 'Date', 'time': 'Time'},
    // Add more ride details here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rides'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: rides.length,
        itemBuilder: (context, index) {
          var ride = rides[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ride['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(ride['destination']),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(ride['date']),
                      Text(ride['time']),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Implement request ride functionality
                    },
                    child: Text('Request'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Color(0xFFF930204),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}