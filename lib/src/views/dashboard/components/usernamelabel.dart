import 'package:flutter/material.dart';

Padding userNameLabel(BuildContext context, String label) {
  TextTheme nameTheme = TextTheme(
      headlineMedium: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.black38,
          fontSize: 30));
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Text(
      label,
      style: Theme.of(context).textTheme.merge(nameTheme).headlineMedium,
    ),
  );
}