import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';




class ClinicDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context)?.settings.arguments;
     if (args == null || args is! String) {
      return Scaffold(
        appBar: AppBar(title: Text("Clinic Reviews")),
        body: Center(child: Text("❌ Error: No clinic ID provided.")),
      );
    }



    final clinicId = args;
    final reviewsQuery = FirebaseFirestore.instance.collection('reviews').where('clinicId', isEqualTo: clinicId);

    return Scaffold(
      appBar: AppBar(title: Text("Clinic Reviews"),
      centerTitle: true,),
      
      body: Column(
        children: [
          SizedBox(height: 16),
          ElevatedButton.icon(
            icon: Icon(Icons.rate_review),
            label: Text("Add / Edit My Review"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/addReview', arguments: clinicId);
            },
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: reviewsQuery.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No reviews yet."));
                }

                final docs = snapshot.data!.docs;

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    final review = docs[index];
                    final comment = review['comment'] ?? '';
                    final rating = review['rating']?.toString() ?? 'N/A';

                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person, color: Colors.indigo),
                        title: Text(comment),
                        subtitle: Text('Rating: $rating'),
                        trailing:  Row(
  mainAxisSize: MainAxisSize.min,
  children: List.generate(
    int.tryParse(rating) ?? 0,
    (index) => Icon(Icons.star, color: Colors.amber, size: 20),
  ),
                      ),
                      ),
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
