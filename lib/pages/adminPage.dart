import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/EditMedicinesPage.dart';
import 'package:flutter_application_1/pages/login.dart';

// ---------------- Admin Page ----------------
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const OrdersPage(),
    const EditMedicinesPage(),
    const SizedBox.shrink(), // Placeholder for logout
  ];

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? "Orders"
              : selectedIndex == 1
              ? "Edit Medicines"
              : "Logout",
        ),
        backgroundColor: const Color(0xFF16917C),
      ),
      body: selectedIndex == 2
          ? Center(
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16917C),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF16917C),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 2) {
            _logout(); // Logout immediately when clicked
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Medicines',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
      ),
    );
  }
}

// ---------------- Orders Page ----------------
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // Dummy orders list
  List<Map<String, dynamic>> orders = [
    {
      "orderId": "ORD001",
      "user": "John Doe",
      "medicine": "Paracetamol",
      "quantity": 2,
      "total": 100,
      "status": "Pending",
    },
    {
      "orderId": "ORD002",
      "user": "Alice Smith",
      "medicine": "Amoxicillin",
      "quantity": 1,
      "total": 120,
      "status": "Pending",
    },
    {
      "orderId": "ORD003",
      "user": "Bob Johnson",
      "medicine": "Ibuprofen",
      "quantity": 3,
      "total": 210,
      "status": "Pending",
    },
    {
      "orderId": "ORD004",
      "user": "John Doe",
      "medicine": "Paracetamol",
      "quantity": 1,
      "total": 50,
      "status": "Pending",
    },
  ];

  // Status options
  final List<String> statusOptions = ["Pending", "On the Way", "Delivered"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID: ${order['orderId']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text("User: ${order['user']}"),
                Text("Medicine: ${order['medicine']}"),
                Text("Quantity: ${order['quantity']}"),
                Text("Total: Rs. ${order['total']}"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Status: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: order['status'],
                      items: statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (newStatus) {
                        setState(() {
                          orders[index]['status'] = newStatus!;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Order ${order['orderId']} status changed to $newStatus",
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
