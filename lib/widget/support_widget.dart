import 'package:flutter/widgets.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle normalTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headdingTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 60,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightWeightTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(255, 145, 145, 145),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle detailsbold() {
    return TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle detailslight() {
    return TextStyle(
      color: Color.fromARGB(255, 134, 133, 133),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
