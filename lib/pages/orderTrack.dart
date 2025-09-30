import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart'; 
import 'package:flutter_application_1/widget/support_widget.dart';

class Ordertrack extends StatefulWidget {
  const Ordertrack({super.key});

  @override
  State<Ordertrack> createState() => _OrdertrackState();
}

class _OrdertrackState extends State<Ordertrack> {
  // Mock data for the order status timeline
  final List<Map<String, dynamic>> orderSteps = [
    {
      'title': 'Order Placed',
      'subtitle': 'Awaiting confirmation',
      'isComplete': true,
    },
    {
      'title': 'Processing',
      'subtitle': 'Pharmacy preparing items',
      'isComplete': true,
    },
    {
      'title': 'Out for Delivery',
      'subtitle': 'The driver is on their way',
      'isComplete': false,
    },
    {
      'title': 'Delivered',
      'subtitle': 'Order received successfully',
      'isComplete': false,
    },
  ];

  // Helper widget to build each step in the timeline
  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required bool isComplete,
    required bool isLast,
  }) {
    final Color primaryColor = const Color(0xFF16917C);
    final Color secondaryColor = Colors.grey.shade400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isComplete ? primaryColor : secondaryColor,
                border: Border.all(
                  color: isComplete ? primaryColor : secondaryColor,
                  width: 3,
                ),
              ),
              child: isComplete
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 3,
                height: 70,
                color: isComplete ? primaryColor : secondaryColor,
              ),
          ],
        ),
        const SizedBox(width: 20),
        Padding(
          padding: EdgeInsets.only(top: isComplete ? 0 : 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppWidget.detailsbold().copyWith(
                  fontSize: 18,
                  color: isComplete ? Colors.black : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isComplete
                      ? Colors.grey.shade600
                      : Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Text(
                          'Track Your Order',
                          style: AppWidget.headdingTextFeildStyle(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'Order ID: #PHMLK12345',
                          style: AppWidget.detailsbold().copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Status: In Progress',
                          style: AppWidget.detailsbold().copyWith(
                            color: const Color(0xFF16917C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Timeline
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: List.generate(orderSteps.length, (index) {
                            return _buildTimelineStep(
                              title: orderSteps[index]['title'],
                              subtitle: orderSteps[index]['subtitle'],
                              isComplete: orderSteps[index]['isComplete'],
                              isLast: index == orderSteps.length - 1,
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Estimated Delivery Card
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1DC794),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF1DC794),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Estimated Delivery:',
                                  style: AppWidget.detailsbold(),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Today, 4:00 PM',
                                  style: AppWidget.detailsbold().copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Return Home Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false, // Remove all previous routes
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF16917C),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Return Home',
                              style: AppWidget.boldTextFeildStyle().copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
