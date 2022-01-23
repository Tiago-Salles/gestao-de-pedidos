import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/app_widget.dart';

void main() async {
  runApp(const AppWidget());
  await Firebase.initializeApp();
}

