import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/savedPrescriptionsPage.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  String userName = "User";
  String userEmail = "user@example.com";

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _fetchUserDetails();
  }

  // Fetch user details from Firestore
  Future<void> _fetchUserDetails() async {
    if (_user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();
      if (doc.exists) {
        setState(() {
          userName = doc['name'] ?? "User";
          userEmail = doc['email'] ?? "user@example.com";
        });
      }
    }
  }

  // Logout function
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  Widget _buildProfileMenuItem({
    required String title,
    bool showArrow = true,
    bool isPrimary = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: GestureDetector(
        onTap: onTap ?? () => print('Tapped on $title'),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                if (showArrow)
                  const Icon(Icons.keyboard_arrow_right, color: Colors.black),
              ],
            ),
            if (isPrimary)
              Divider(color: Colors.grey.shade300, height: 20, thickness: 1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              margin: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'User Profile',
                  style: AppWidget.headdingTextFeildStyle(),
                ),
              ),
            ),

            // Avatar & User Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 204, 204, 204),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: AppWidget.detailsbold().copyWith(fontSize: 20),
                      ),
                      Text(userEmail, style: AppWidget.detailslight()),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildProfileMenuItem(title: 'Past Orders', isPrimary: true),
            const SizedBox(height: 10),

            // Saved Prescriptions: Navigate to SavedPrescriptionsPage
            _buildProfileMenuItem(
              title: 'Saved Prescriptions',
              showArrow: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SavedPrescriptionsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            _buildProfileMenuItem(title: 'Settings', showArrow: false),
            const SizedBox(height: 10),

            // Log Out
            _buildProfileMenuItem(
              title: 'Log Out',
              showArrow: false,
              onTap: _logout,
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
