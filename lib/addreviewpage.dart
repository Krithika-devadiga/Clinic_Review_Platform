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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<int>(
              value: rating,
              onChanged: (value) => setState(() => rating = value ?? 3),
              items: [1, 2, 3, 4, 5]
                  .map((e) => DropdownMenuItem(value: e, child: Text('$e Stars')))
                  .toList(),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Your comment'),
            ),
            ElevatedButton(
              onPressed: () async {
                await reviewDoc.set({
                  'clinicId': clinicId,
                  'userId': userId,
                  'rating': rating,
                  'comment': commentController.text,
                  'timestamp': Timestamp.now()
                });

                // Update clinic average
                final reviews = await FirebaseFirestore.instance
                    .collection('reviews')
                    .where('clinicId', isEqualTo: clinicId)
                    .get();

                final allRatings = reviews.docs.map((doc) => doc['rating'] as int).toList();
                final avg = allRatings.reduce((a, b) => a + b) / allRatings.length;

                await FirebaseFirestore.instance.collection('clinics').doc(clinicId).update({
                  'averageRating': avg,
                });

                Navigator.pop(context);
              },
              child: Text("Submit Review"),
            ),
          ],
        ),
      ),
    );
  }
}
