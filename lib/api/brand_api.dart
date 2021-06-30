import 'package:flutter_pagination/constant.dart';
import 'package:flutter_pagination/models/brands.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<BrandList> fetchAllBrand(int nextPage) async {
  final response =
  await http.get(Uri.https(baseUrl, '/api/brands', {'q': '{http}','page':'$nextPage'},));

  if (response.statusCode == 200) {
    return BrandList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Category');
  }
}