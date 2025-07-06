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

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final clinic = docs[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.local_hospital, color: Colors.teal),
                  title: Text(clinic['name'] ?? 'Unnamed Clinic'),
                  subtitle: Text(clinic['location'] ?? 'Unknown Location'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/clinic',
                      arguments: clinic.id,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addReview');
        },
        child: Icon(Icons.add),
        tooltip: "Add Review"
      ),
    );
  }
}
