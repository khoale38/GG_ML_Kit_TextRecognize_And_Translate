import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/home_screen.dart';
import 'package:untitled/translate.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TranslateModel(),
      child: const MaterialApp(home: HomeScreen()),
    ),
  );
}