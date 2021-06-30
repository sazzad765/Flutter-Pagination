import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';


class BrandScreen extends StatelessWidget {
  static String routeName = "/brand_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand'),
      ),
      body: Body(),
    );
  }
}