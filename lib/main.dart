import 'package:flutter/material.dart';
import 'package:flutter_pagination/ui/brand_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pagination',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BrandScreen(),
    );
  }
}

