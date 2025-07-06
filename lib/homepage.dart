import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicsRef = FirebaseFirestore.instance.collection('clinics');

    return Scaffold(
      appBar: AppBar(title: Text("Clinic List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: clinicsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(child: Text("No clinics found. Add one in Firestore."));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final clinic = docs[index];
              return ListTile(
                title: Text(clinic['name'] ?? 'Unnamed Clinic'),
                subtitle: Text(clinic['location'] ?? ''),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/clinic',
                    arguments: clinic.id, // Pass clinicId to ClinicDetailsPage
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddReviewPage — optionally pass a default clinicId
          Navigator.pushNamed(context, '/addReview');
        },
        child: Icon(Icons.add),
        tooltip: "Add Review",
      ),
    );
  }
}
