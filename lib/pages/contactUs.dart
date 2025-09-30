import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        // Added SingleChildScrollView for safety
        child: Container(
          margin: const EdgeInsets.only(top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Contact Us',
                  style: AppWidget.headdingTextFeildStyle(),
                ),
              ),

              // --- Email Section ---
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text('Email', style: AppWidget.detailsbold()),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text(
                  'pharmalink@gmail.com',
                  style: AppWidget.detailslight(),
                ),
              ),

              // --- Phone Section ---
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text('Phone', style: AppWidget.detailsbold()),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text('+940123456789', style: AppWidget.detailslight()),
              ),

              // --- WhatsApp Section (Regular) ---
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text('WhatsApp', style: AppWidget.detailsbold()),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50),
                child: Text('+940123456789', style: AppWidget.detailslight()),
              ),

              // --- Emergency WhatsApp Card (Completed Part) ---
              Container(
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  // Adjusted color to match the teal/cyan image (image_fcedd2.png)
                  color: const Color(0xFF5AADA9),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Emergency Text (Red)
                      Text(
                        'Emergency',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // 2. WhatsApp Us Text (White)
                      Text(
                        'WhatsApp Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        '+94764217765',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
