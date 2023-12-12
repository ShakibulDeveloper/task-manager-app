import 'package:flutter/material.dart';

void showSnackBar(context, String message, [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
