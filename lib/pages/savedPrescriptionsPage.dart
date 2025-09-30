import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedPrescriptionsPage extends StatefulWidget {
  const SavedPrescriptionsPage({super.key});

  @override
  State<SavedPrescriptionsPage> createState() => _SavedPrescriptionsPageState();
}

class _SavedPrescriptionsPageState extends State<SavedPrescriptionsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to see your prescriptions.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Prescriptions"),
        backgroundColor: const Color(0xFF16917C),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('prescriptions')
            .where('userId', isEqualTo: user!.uid) // must match saved userId
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final prescriptions = snapshot.data!.docs;

          if (prescriptions.isEmpty) {
            return const Center(child: Text("No prescriptions uploaded yet."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: prescriptions.length,
            itemBuilder: (context, index) {
              final doc = prescriptions[index];
              final instructions = doc['instructions'] ?? '';
              final base64Image = doc['imageBase64'] ?? '';

              Widget imageWidget;
              if (base64Image.isNotEmpty) {
                try {
                  imageWidget = Image.memory(
                    base64Decode(base64Image),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                } catch (_) {
                  imageWidget = Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Icon(Icons.broken_image)),
                  );
                }
              } else {
                imageWidget = Container(
                  height: 200,
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.image)),
                );
              }

              final uploadTime = doc['createdAt'] != null
                  ? (doc['createdAt'] as Timestamp)
                        .toDate()
                        .toLocal()
                        .toString()
                        .split('.')[0]
                  : 'Unknown';

              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageWidget,
                      const SizedBox(height: 10),
                      const Text(
                        "Doctor's Instructions:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(instructions),
                      const SizedBox(height: 10),
                      Text(
                        "Uploaded on: $uploadTime",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
