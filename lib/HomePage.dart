import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './RideOptionScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _signInWithGoogle() async {
      try {
        final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '128602331951-rkdhgh1r7s348d3uindqclkv2b3rims2.apps.googleusercontent.com');
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RideOptionScreen()),
        );
      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.asset(
            'images/landingimage.png',
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Text(
            'Log in to your account',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Color(0xFF930204)),
          ),
          SizedBox(height: 40),
          SignInButton(
            Buttons.Google,
            text: "Continue with Google",
            onPressed: _signInWithGoogle,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          Expanded(child: Container()), // This will push the following widgets towards the bottom
          Divider(color: Color(0xFF930204), thickness: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Riding Together, Howling for Sustainability',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF930204),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Divider(color: Color(0xFF930204), thickness: 2),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05), // Adjust this to move the bottom divider up or down
        ],
      ),
    );
  }
}



