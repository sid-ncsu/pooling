import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CO2 Savings Display',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: EmissionsSavingsPage(),
    );
  }
}

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  Future<String> generateResponse(double distance, int numberOfPeople) async {
    final url = Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final prompt = 'Calculate the total CO2 emissions for a distance of $distance kilometers for one car, and then calculate the CO2 emissions saved if that distance was shared between $numberOfPeople people.';
    final body = json.encode({
      'prompt': prompt,
      'max_tokens': 150,
      'temperature': 0.7,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['choices'][0]['text'];
    } else {
      return (1.21 * distance * numberOfPeople+1).toStringAsFixed(2);
    }
  }
}

class EmissionsSavingsPage extends StatefulWidget {
  @override
  _EmissionsSavingsPageState createState() => _EmissionsSavingsPageState();
}

class _EmissionsSavingsPageState extends State<EmissionsSavingsPage> {
  var _emissionsSaved = 'Loading...';
  final OpenAIService openAIService = OpenAIService('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'); // Securely load your API key
  Random random = Random();
  Future<void> _calculateEmissions() async {
    double distance = random.nextDouble()*10; // Example distance
    int numberOfPeople = random.nextInt(4); // Example number of people

    try {
      final response = await openAIService.generateResponse(distance, numberOfPeople);
      setState(() {
        _emissionsSaved = response.trim();
      });
    } catch (e) {
      setState(() {
        _emissionsSaved = (1.21 * distance * numberOfPeople+1).toStringAsFixed(2);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateEmissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CO2 Emissions Savings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Booking Confirmed', style: TextStyle(color: Colors.green,  fontSize: 20.0, fontWeight: FontWeight.bold)),
            Icon(Icons.eco, color: Colors.green, size: 48.0),
            SizedBox(height: 8.0),
            Text('Yayy! You saved $_emissionsSaved kg CO2 today', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            // ElevatedButton(
            //   onPressed: _calculateEmissions,
            //   child: Text('Recalculate Emissions Savings'),
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            // ),
          ],
        ),
      ),
    );
  }
}
