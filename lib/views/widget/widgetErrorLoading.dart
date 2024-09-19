import 'package:flutter/material.dart';

Widget widgetErrorLoading({required String message, required Function() func}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.warning,
        color: Colors.amber,
        size: 60,
      ),
      Center(
        child: Text(message),
      ),
      ElevatedButton(
        onPressed: () {
          func();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
        ),
        child: const Text("Try Again"),
      ),
    ],
  );
}
