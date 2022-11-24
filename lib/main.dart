import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sembako_bintang/app/app.dart';
import './app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init("");
  runApp(const MyApp());
}

