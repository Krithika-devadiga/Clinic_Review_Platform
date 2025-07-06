import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'AddReviewPage.dart';
import 'ClinicalDetailsPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart'; 

import 'SplashScreen.dart';

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
      theme: ThemeData(
        useMaterial3: true, // Optional for modern design
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 211, 82, 129),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87,
              displayColor: Colors.black87,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.teal,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.teal.shade50,
        ),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),

        '/home': (context) => HomePage(),
        '/clinic': (context) => ClinicDetailsPage(),
        '/addReview': (context) => AddReviewPage(),
        '/register': (context) => RegisterPage(), // ✅ added
      },
    );
  }
}
