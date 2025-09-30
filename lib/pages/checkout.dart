import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

enum DeliveryOption { home, pickup }

class _CheckOutState extends State<CheckOut> {
  DeliveryOption _selectedOption = DeliveryOption.home;

  // Mock data for calculation
  final double subtotal = 350.50; // Example total cost of items
  final double totalDiscount = 35.00; // Example discount amount
  final double deliveryFee = 5.00; // Example delivery fee
  late final double grandTotal = subtotal - totalDiscount + deliveryFee;

  // Helper widget for the delivery time placeholder
  Widget _buildDeliveryTimePlaceholder() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder Image/Icon area
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 15),
          // Placeholder Text lines
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 10,
                color: Colors.grey.shade400,
                margin: const EdgeInsets.only(bottom: 5),
              ),
              Container(width: 100, height: 10, color: Colors.grey.shade400),
            ],
          ),
        ],
      ),
    );
  }

  // UPDATED: Helper widget for the custom selection box (used for both Home Delivery and Local Pickup)
  Widget _buildSelectionBox({
    required DeliveryOption value,
    required String title,
  }) {
    final isSelected = _selectedOption == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: const EdgeInsets.only(bottom: 20), // Reduced margin slightly
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF16917C).withOpacity(0.05)
              : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF16917C) : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppWidget.detailsbold().copyWith(
                color: isSelected ? const Color(0xFF16917C) : Colors.black,
              ),
            ),
            // Optional: Show a checkmark or similar indicator when selected
            if (isSelected)
              const Icon(
                Icons.check_circle,
                size: 24,
                color: Color(0xFF16917C),
              ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display the total calculation details
  Widget _buildTotalDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Subtotal Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal:', style: AppWidget.detailslight()),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: AppWidget.detailsbold(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Total Discount Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Discount:', style: AppWidget.detailslight()),
              Text(
                '-\$${totalDiscount.toStringAsFixed(2)}',
                style: AppWidget.detailsbold().copyWith(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Delivery Fee Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee:', style: AppWidget.detailslight()),
              Text(
                '\$${deliveryFee.toStringAsFixed(2)}',
                style: AppWidget.detailsbold(),
              ),
            ],
          ),

          const Divider(height: 30, color: Colors.grey),

          // Grand Total Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total:',
                style: AppWidget.detailsbold().copyWith(fontSize: 20),
              ),
              Text(
                '\$${grandTotal.toStringAsFixed(2)}',
                style: AppWidget.detailsbold().copyWith(
                  fontSize: 22,
                  color: const Color(0xFF16917C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Checkout',
                  style: AppWidget.headdingTextFeildStyle(),
                ),
              ),

              const SizedBox(height: 30),

              // --- Estimated Delivery Time Header ---
              Text(
                'Estimated Delivery Time',
                style: AppWidget.detailsbold().copyWith(fontSize: 18),
              ),
              const Divider(color: Colors.black, thickness: 1, height: 10),

              const SizedBox(height: 10),

              // --- Delivery Time Placeholder ---
              _buildDeliveryTimePlaceholder(),

              // --- Delivery Options (Both using the Box Design) ---
              _buildSelectionBox(
                value: DeliveryOption.home,
                title: 'Home Delivery',
              ),
              _buildSelectionBox(
                value: DeliveryOption.pickup,
                title: 'Local Pickup',
              ),

              const SizedBox(height: 20),

              _buildTotalDetails(),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF16917C), // Teal button color
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Check Out',
                    style: AppWidget.boldTextFeildStyle(),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
