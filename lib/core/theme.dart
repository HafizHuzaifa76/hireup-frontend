import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
  scaffoldBackgroundColor: const Color(0xFFF5F7FA),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      color: Colors.black54,
      fontSize: 16,
    ),
  ),
);
