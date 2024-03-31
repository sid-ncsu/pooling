import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './rides.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


class postride extends StatefulWidget {
  @override
  _postrideState createState() => _postrideState();
}

class _postrideState extends State<postride> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final CollectionReference _ridesCollection = FirebaseFirestore.instance.collection('rides');

  Future<Position?> getLocation() async {
  try {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it here
      return null;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Return the position object
    return position;
  } catch (e) {
    // Handle errors
    print(e.toString());
    return null;
  }
}
  // Validate date format
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
      return null;
    } catch (_) {
      return 'Please enter a valid date in the format YYYY-MM-DD';
    }
  }

  // Validate time format
  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a time';
    }
    try {
      DateFormat('HH:mm').parseStrict(value);
      return null;
    } catch (_) {
      return 'Please enter a valid time in the format HH:mm';
    }
  }

  // Validate numeric input
  String? _validateNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  // Submit form data
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Access FirebaseAuth instance to get current user
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Access Firestore instance
          FirebaseFirestore firestore = FirebaseFirestore.instance;

          // Convert date string to DateTime object
        DateTime date = DateFormat('yyyy-MM-dd').parse(_dateController.text);

        // Convert time string to DateTime object
        DateTime time = DateFormat('HH:mm').parse(_timeController.text);

        // Convert seats and amount to integers or doubles
        int seats = int.parse(_seatsController.text);
        double amount = double.parse(_amountController.text);
        Position? position = await getLocation();
        // Create Firestore data map
        Map<String, dynamic> rideData = {
          'destination': _destinationController.text,
          'date': Timestamp.fromDate(date), // Convert DateTime to Timestamp
          'time': Timestamp.fromDate(time), // Convert DateTime to Timestamp
          'seats': seats,
          'amount': amount,
          'longitude':position?.longitude,
          'latitude' : position?.latitude
        };

        // Update Firestore document
        await firestore.collection('rides').doc(user.uid).set(rideData);

          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Submission'),
              content: Text('Data submitted successfully!'),
            ),
          );

          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreScreen()),
    );
        } else {
          // If user is null, handle the scenario where the user is not signed in
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('User not signed in.'),
            ),
          );
        }
      } catch (error) {
        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit data. Error: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Ride'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Text(
              'My Ride',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _destinationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Destination',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Destination Required';
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter date (YYYY-MM-DD)',
              ),
              validator: _validateDate,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter time (HH:mm)',
              ),
              validator: _validateTime,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _seatsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter number of seats',
              ),
              keyboardType: TextInputType.number,
              validator: _validateNumeric,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter the amount',
              ),
              keyboardType: TextInputType.number,
              validator: _validateNumeric,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _seatsController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}