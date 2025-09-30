import 'package:flutter/material.dart';

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
      "status": "Completed",
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
