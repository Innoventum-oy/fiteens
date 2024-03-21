import 'package:flutter/material.dart';

Widget userNameLabel(BuildContext context, String label) {
  TextTheme nameTheme = const TextTheme(
      headlineMedium: TextStyle(
          color: Colors.white,
       //   backgroundColor: Colors.black38,
          fontSize: 30));
  return GestureDetector(
      onTap: () {
    Navigator.pushNamed(context, '/user');
  },
  child:Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      label,
      style: Theme.of(context).textTheme.merge(nameTheme).headlineMedium,
    ),
  ),
  );
}