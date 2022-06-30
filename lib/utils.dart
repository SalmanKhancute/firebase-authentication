import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utils {
  static push(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  static pushReplacement(BuildContext context, Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }
}

Widget elevatedButton({
  required String title,
  required IconData icon,
  required VoidCallback onPress,
}) {
  return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          minimumSize: const Size(double.infinity, 40)),
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      onPressed: onPress,
      icon: FaIcon(icon));
}
