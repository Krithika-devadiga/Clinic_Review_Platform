import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'AddReviewPage.dart';
import 'ClinicalDetailsPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart'; // ✅ Include register page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAT_NC25vx1N8G4rmxKm151eIPLceW6yAI",
      authDomain: "clinicreview-cf455.firebaseapp.com",
      projectId: "clinicreview-cf455",
      storageBucket: "clinicreview-cf455.firebasestorage.app",
      messagingSenderId: "477124610175",
      appId: "1:477124610175:web:7b2746d19a31617154574a"

    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Review App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/clinic': (context) => ClinicDetailsPage(),
        '/addReview': (context) => AddReviewPage(),
        '/register': (context) => RegisterPage(), // ✅ added
      },
    );
  }
}
