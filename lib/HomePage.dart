// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import './RideOptionScreen.dart';


// class HomePage extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     Future<void> _signInWithGoogle() async {
//   try {
//     // Initialize GoogleSignIn with your client ID
//     final GoogleSignIn googleSignIn = GoogleSignIn(clientId: '128602331951-rkdhgh1r7s348d3uindqclkv2b3rims2.apps.googleusercontent.com');
    
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => RideOptionScreen()),
//     );
//   } catch (error) {
//     print(error);
//   }
// }
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Log in to your account', style: TextStyle(fontSize: 24.0)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _signInWithGoogle,
//               child: Text('Continue with Google'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black, 
//                 backgroundColor: Colors.white,
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(children: <Widget>[
//               Expanded(child: Divider()),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text('OR'),
//               ),
//               Expanded(child: Divider()),
//             ]),
//             SizedBox(height: 20),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Log in'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFFF930204),
//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './RideOptionScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Future<void> _signInWithGoogle() async {
  try {
    // Initialize GoogleSignIn with your client ID
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
      body: Center( // Center the content vertically and horizontally
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Log in to your account', style: TextStyle(fontSize: 24.0)),
              SizedBox(height: 40),
              SignInButton(
                Buttons.Google,
                text: "Continue with Google",
                onPressed: _signInWithGoogle,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Increase button padding
                elevation: 0, // Remove button elevation
              ),
            ],
          ),
        ),
      ),
    );
  }
}