import 'package:flutter/material.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Battleships',
    home: LoginScreen()
  ));
}
