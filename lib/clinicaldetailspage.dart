import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';




class ClinicDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clinicId = ModalRoute.of(context)!.settings.arguments as String;
    final reviews = FirebaseFirestore.instance.collection('reviews').where('clinicId', isEqualTo: clinicId);

    return Scaffold(
      appBar: AppBar(title: Text("Clinic Reviews")),
      body: Column(
        children: [
          ElevatedButton(
            child: Text("Add / Edit My Review"),
            onPressed: () {
              Navigator.pushNamed(context, '/addReview', arguments: clinicId);
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: reviews.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final review = docs[index];
                    return ListTile(
                      title: Text(review['comment']),
                      subtitle: Text("Rating: ${review['rating']}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
