import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/savedPrescriptionsPage.dart';
import 'package:flutter_application_1/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';

class MultilineTextBox extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  const MultilineTextBox({
    super.key,
    this.hintText = 'Type here',
    this.maxLines = 5,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 187, 180, 191);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: borderColor),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: borderColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 130, 110, 180),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}

class PrescriptionUpload extends StatefulWidget {
  const PrescriptionUpload({super.key});

  @override
  State<PrescriptionUpload> createState() => _PrescriptionUploadState();
}

class _PrescriptionUploadState extends State<PrescriptionUpload> {
  final TextEditingController instructionsController = TextEditingController();
  File? _pickedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> submitPrescription() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_pickedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }

    final bytes = await _pickedImage!.readAsBytes();
    final base64Image = base64Encode(bytes);

    // Save prescription to Firestore
    await FirebaseFirestore.instance.collection('prescriptions').add({
      'userId': user.uid, // important: exact field name
      'imageBase64': base64Image, // exact field name
      'instructions': instructionsController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prescription uploaded successfully')),
    );

    // Redirect to Saved Prescriptions page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SavedPrescriptionsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Upload Prescription',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9C9C9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _pickedImage != null
                    ? Image.file(_pickedImage!, fit: BoxFit.cover)
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 40, color: Color(0xFF646363)),
                          SizedBox(height: 5),
                          Text(
                            'Upload\nPrescription',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF646363),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Doctor's Instructions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            MultilineTextBox(controller: instructionsController, maxLines: 6),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: submitPrescription,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF16917C),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Submit Prescription',
                    style: AppWidget.boldTextFeildStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
