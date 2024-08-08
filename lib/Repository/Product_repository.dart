// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<dynamic>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
