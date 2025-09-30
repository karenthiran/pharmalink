import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/support_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Search & Browse',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFC9C9C9),
              borderRadius: BorderRadius.circular(7),
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Medicines',
                  hintStyle: AppWidget.lightWeightTextFeildStyle(),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF646363),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
