import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditMedicinesPage extends StatefulWidget {
  const EditMedicinesPage({super.key});

  @override
  State<EditMedicinesPage> createState() => _EditMedicinesPageState();
}

class _EditMedicinesPageState extends State<EditMedicinesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Future<void> addMedicine() async {
    final name = nameController.text.trim();
    final price = priceController.text.trim();

    if (name.isEmpty || price.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select image"),
        ),
      );
      return;
    }

    // Upload image to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('medicines/$fileName.jpg');
    await ref.putFile(_pickedImage!);
    final imageUrl = await ref.getDownloadURL();

    // Add medicine to Firestore
    await FirebaseFirestore.instance.collection('medicines').add({
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Clear inputs
    nameController.clear();
    priceController.clear();
    setState(() => _pickedImage = null);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medicine added successfully")),
    );
  }

  Future<void> deleteMedicine(String docId) async {
    await FirebaseFirestore.instance
        .collection('medicines')
        .doc(docId)
        .delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Medicine deleted")));
  }

  Future<void> updateMedicine(
    String docId,
    String currentName,
    String currentPrice,
  ) async {
    final TextEditingController updateNameController = TextEditingController(
      text: currentName,
    );
    final TextEditingController updatePriceController = TextEditingController(
      text: currentPrice,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Medicine"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: updateNameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: updatePriceController,
              decoration: const InputDecoration(labelText: "Price"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedName = updateNameController.text.trim();
              final updatedPrice = updatePriceController.text.trim();
              if (updatedName.isNotEmpty && updatedPrice.isNotEmpty) {
                await FirebaseFirestore.instance
                    .collection('medicines')
                    .doc(docId)
                    .update({'name': updatedName, 'price': updatedPrice});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Medicine updated")),
                );
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF16917C),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF16917C),
          tabs: const [
            Tab(text: "Add Medicine", icon: Icon(Icons.add)),
            Tab(text: "Edit/Delete", icon: Icon(Icons.edit)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // ---------------- Add Medicine ----------------
              Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: _pickedImage != null
                              ? Image.file(_pickedImage!, fit: BoxFit.cover)
                              : const Center(
                                  child: Icon(Icons.add_a_photo, size: 50),
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Medicine Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: addMedicine,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16917C),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Add Medicine"),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------------- Edit/Delete Medicines ----------------
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("medicines")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Map<String, dynamic>> medicinesList = [
                    // Dummy medicines
                    {
                      "name": "Paracetamol",
                      "price": "50",
                      "imageUrl": null,
                      "isDummy": true,
                    },
                    {
                      "name": "Amoxicillin",
                      "price": "120",
                      "imageUrl": null,
                      "isDummy": true,
                    },
                  ];

                  // Firestore medicines
                  if (snapshot.hasData) {
                    for (var doc in snapshot.data!.docs) {
                      medicinesList.add({
                        "id": doc.id,
                        "name": doc["name"],
                        "price": doc["price"],
                        "imageUrl": doc["imageUrl"],
                        "isDummy": false,
                      });
                    }
                  }

                  return ListView.builder(
                    itemCount: medicinesList.length,
                    itemBuilder: (context, index) {
                      var med = medicinesList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: med["imageUrl"] != null
                              ? Image.network(med["imageUrl"], width: 50)
                              : const Icon(Icons.medical_services),
                          title: Text(med["name"] ?? "No Name"),
                          subtitle: Text("Price: Rs. ${med["price"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: med["isDummy"]
                                    ? null
                                    : () => updateMedicine(
                                        med["id"],
                                        med["name"] ?? "",
                                        med["price"] ?? "",
                                      ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: med["isDummy"]
                                    ? null
                                    : () => deleteMedicine(med["id"]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
