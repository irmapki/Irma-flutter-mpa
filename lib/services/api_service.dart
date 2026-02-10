import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/order_model.dart';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.6:8000/api';

  // Headers dengan token
  static Future<Map<String, String>> getHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ==================== PRODUCTS ====================
  
  // Get all products
  static Future<List<Product>> getProducts() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==================== ORDERS ====================
  
  // Get all orders
  static Future<List<Order>> getOrders() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> ordersJson = data['data'];
        return ordersJson.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get order detail
  static Future<Order> getOrderDetail(int orderId) async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/orders/$orderId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Order.fromJson(data['data']);
      } else {
        throw Exception('Failed to load order detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Create order
  static Future<Order> createOrder({
    required String transactionTime,
    required int kasirId,
    required int totalPrice,
    required int totalItem,
    required String paymentMethod,
    required List<Map<String, dynamic>> orderItems,
  }) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: headers,
        body: json.encode({
          'transaction_time': transactionTime,
          'kasir_id': kasirId,
          'total_price': totalPrice,
          'total_item': totalItem,
          'payment_method': paymentMethod,
          'order_items': orderItems,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        return Order.fromJson(data['data']);
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to create order');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}