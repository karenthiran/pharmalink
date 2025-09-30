import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // 🔹 Register function
  Future<void> register() async {
    setState(() => isLoading = true);

    try {
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      if (user != null) {
        // Firestore: Save user details
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'isAdmin': false, // Normal user
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully!")),
        );

        // Clear fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();

        // Navigate directly to Home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong";
      if (e.code == 'weak-password') {
        message = "The password is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "This email is already registered.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format.";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 140),
                Text('SignUp', style: AppWidget.headdingTextFeildStyle()),
                Text('Welcome', style: AppWidget.lightWeightTextFeildStyle()),
                const SizedBox(height: 50),

                // Name
                _buildTextField("Name", nameController, false),
                const SizedBox(height: 30.0),

                // Email
                _buildTextField("Email Address", emailController, false),
                const SizedBox(height: 30.0),

                // Password
                _buildTextField("Password", passwordController, true),
                const SizedBox(height: 40),

                // Sign Up Button
                isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: register,
                        child: Container(
                          width: screenWidth * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF16917C),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'SignUp',
                              style: AppWidget.boldTextFeildStyle(),
                            ),
                          ),
                        ),
                      ),

                const Spacer(),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 139, 136, 136),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'SignIn',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Helper function to build text fields
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool obscure,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF16917C),
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Enter Your $label',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF16917C), width: 2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
