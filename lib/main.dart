import 'package:flutter/material.dart';
import 'package:billing/home.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Material();
  };
  runApp(
    const MaterialApp(
      home: Scaffold(
        //backgroundColor: Color.fromARGB(255, 183, 26, 214),
        body: GradientContainer(),
      ),
    ),
  );
}
