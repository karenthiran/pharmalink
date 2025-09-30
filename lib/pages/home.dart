import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cart.dart';
import 'package:flutter_application_1/pages/prescriptionUpload.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/search.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Search(),
    const Cart(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF16917C),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// --------------------------
// Home page content widget
// --------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  // Dummy medicine list
  final List<Map<String, String>> dummyMedicines = const [
    {"name": "Paracetamol", "stock": "In Stock", "price": "Rs. 100"},
    {"name": "Amoxicillin", "stock": "In Stock", "price": "Rs. 120"},
    {"name": "Ibuprofen", "stock": "Out of Stock", "price": "Rs. 150"},
    {"name": "Cough Syrup", "stock": "In Stock", "price": "Rs. 200"},
    {"name": "Vitamin C", "stock": "In Stock", "price": "Rs. 80"},
    {"name": "Antacid", "stock": "In Stock", "price": "Rs. 50"},
    {"name": "Pain Relief Gel", "stock": "Out of Stock", "price": "Rs. 250"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text('Home', style: AppWidget.headdingTextFeildStyle()),
            ),

            // Search box
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Search()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9C9C9),
                  borderRadius: BorderRadius.circular(7),
                ),
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Medicines',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF646363)),
                    ),
                  ),
                ),
              ),
            ),

            // Feature buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureButton(context, Icons.add, 'Upload\nPrescription'),
                _buildFeatureButton(
                  context,
                  Icons.check_circle_outline_outlined,
                  'Discounts',
                ),
                _buildFeatureButton(context, Icons.book_outlined, 'Orders'),
              ],
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Featured Medicines',
                style: AppWidget.normalTextFeildStyle(),
              ),
            ),

            const SizedBox(height: 10),

            // Medicine list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyMedicines.length,
              itemBuilder: (context, index) {
                final medicine = dummyMedicines[index];
                return _buildMedicineItem(medicine);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Feature buttons
  Widget _buildFeatureButton(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (label == "Upload\nPrescription") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrescriptionUpload(),
              ),
            );
          } else if (label == "Orders") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Cart()),
            );
          }
        },
        child: Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFC9C9C9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: const Color(0xFF646363)),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF646363),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Medicine item widget
  Widget _buildMedicineItem(Map<String, String> medicine) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFC9C9C9),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medicine['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9C9C9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Add Cart',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(medicine['stock']!),
                const SizedBox(height: 5),
                Text(
                  medicine['price']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
