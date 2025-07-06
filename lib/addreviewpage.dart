import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddReviewPage extends StatefulWidget {
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  int rating = 3;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;




    final clinicId = args is String ? args : null;
    if (clinicId == null) {
    return Scaffold(
    appBar: AppBar(title: Text("Submit Review")),
    body: Center(child: Text("Error: No clinic selected.")),
  );
}
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final reviewDoc = FirebaseFirestore.instance.collection('reviews').doc('$clinicId-$userId');

    return Scaffold(
      appBar: AppBar(title: Text("Submit Review")),


      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        // Rating Dropdown
        DropdownButtonFormField<int>(
          value: rating,
          decoration: InputDecoration(
            labelText: 'Select Rating',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: [1, 2, 3, 4, 5]
              .map((e) => DropdownMenuItem(value: e, child: Text('$e Stars')))
              .toList(),
          onChanged: (value) {
            setState(() {
              rating = value ?? 3;
            });
          },
        ),
        SizedBox(height: 20),

        // Comment TextField with design
        TextField(
          controller: commentController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Your comment',
            hintText: 'Write your review here...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        SizedBox(height: 20),

        // Submit Button
        // Submit Button with fixed width
Center(
  child: SizedBox(
    width: 200, // 👈 Set desired width here
    child: ElevatedButton(
      onPressed: () async {
        final clinicId = ModalRoute.of(context)!.settings.arguments as String;
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final reviewDoc = FirebaseFirestore.instance
            .collection('reviews')
            .doc('$clinicId-$userId');

        await reviewDoc.set({
          'clinicId': clinicId,
          'userId': userId,
          'rating': rating,
          'comment': commentController.text.trim(),
          'timestamp': Timestamp.now(),
        });

        // Update average rating
        final reviews = await FirebaseFirestore.instance
            .collection('reviews')
            .where('clinicId', isEqualTo: clinicId)
            .get();

        final allRatings = reviews.docs.map((doc) => doc['rating'] as int).toList();
        final avg = allRatings.reduce((a, b) => a + b) / allRatings.length;

        await FirebaseFirestore.instance
            .collection('clinics')
            .doc(clinicId)
            .update({'averageRating': avg});

        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text("Submit Review", style: TextStyle(fontSize: 16)),
    ),
  ),
),





      ],
    ),
  ),





    );
  }
}
