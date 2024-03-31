import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreScreen extends StatefulWidget {
  @override
  _FirestoreScreenState createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rides to Pool'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('rides').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildList(context, snapshot.data?.docs ?? []);
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, snapshot[index]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = data.data();
    Timestamp timestamp = (record as Map<String, dynamic>)['date'] ?? "";
    Timestamp time = (record as Map<String, dynamic>)['time'] ?? "";

    DateTime date = timestamp.toDate();

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    DateTime time_ = DateTime.utc(1970, 1, 1, 0, 0, 0).add(Duration(seconds: time.seconds));
    String formattedTime = DateFormat('HH:mm').format(time_);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
  title: Text((record as Map<String, dynamic>)['destination'] ?? ""),
  subtitle: Text(record == null ? "" : 
    "Amount: ${(record as Map<String, dynamic>)['amount'] ?? ""}, " +
    "No. of Seats: ${(record as Map<String, dynamic>)['no_of_seats'] ?? ""}, " +
    "Date: ${formattedDate}, " +
    "Time: ${formattedTime}, " 
  ),
),
      ),
    );
  }
}
