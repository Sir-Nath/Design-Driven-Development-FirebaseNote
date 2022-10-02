import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notepad_firebase_ddd/injection.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('check'),
        ),
        body: const Center(
          child: Text('hello world'),
        ),
      ),
    );
  }
}
