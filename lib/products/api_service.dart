import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiUrl = "http://localhost:8040/products";

  // ดึงข้อมูลสินค้า
  static Future<List> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }

  // เพิ่มสินค้า
  static Future<Map<String, dynamic>?> addProduct(
      String name, String description, double price) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'description': description,
          'price': price,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body); // ส่งสินค้ากลับไป
      } else {
        throw Exception('Failed to add product');
      }
    } catch (error) {
      print('Error adding product: $error');
      return null;
    }
  }

  // ลบสินค้า
  static Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete product');
      }
    } catch (error) {
      print('Error deleting product: $error');
    }
  }

  // อัปเดตสินค้า
  static Future<void> updateProduct(
      String id, String name, String description, double price) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'description': description,
          'price': price,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (error) {
      print('Error updating product: $error');
    }
  }
}
