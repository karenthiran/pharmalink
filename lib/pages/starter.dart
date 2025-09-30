import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/contactUs.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/signUp.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: EdgeInsets.only(top: 125.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentGeometry.center,
              child: Image.asset('images/PharmaLinkLogo.png'),
            ),
            Padding(padding: const EdgeInsets.only(left: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: Container(
                    width: 300.0,
                    padding: EdgeInsets.all(10),
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
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 3,
                    indent: 40,
                    endIndent: 10,
                  ),
                ),

                Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 3,
                    indent: 10,
                    endIndent: 40,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Container(
                    width: 300.0,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 145, 124),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: AppWidget.boldTextFeildStyle(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUs(),
                      ),
                    );
                  },
                  child: Container(
                    child: Text(
                      'CONTACT US',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
