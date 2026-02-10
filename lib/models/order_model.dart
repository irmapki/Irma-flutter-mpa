class Order {
  final int id;
  final String? transactionTime;
  final int totalPrice;
  final int totalItem;
  final int? kasirId;
  final String? paymentMethod;
  final String? kasirName;
  final List<OrderItem>? orderItems;

  Order({
    required this.id,
    this.transactionTime,
    required this.totalPrice,
    required this.totalItem,
    this.kasirId,
    this.paymentMethod,
    this.kasirName,
    this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: _parseInt(json['id']),
      transactionTime: json['transaction_time'],
      totalPrice: _parseInt(json['total_price']),
      totalItem: _parseInt(json['total_item']), // NULL → 0
      kasirId: json['kasir_id'] != null ? _parseInt(json['kasir_id']) : null,
      paymentMethod: json['payment_method'],
      kasirName: json['kasir'] != null ? json['kasir']['name'] : null,
      orderItems: json['order_items'] != null
          ? (json['order_items'] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList()
          : null,
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = double.tryParse(value);
      return parsed?.toInt() ?? 0;
    }
    return 0;
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final int productPrice;
  final int quantity;
  final int subtotal;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.subtotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: Order._parseInt(json['id']),
      orderId: Order._parseInt(json['order_id']),
      productId: Order._parseInt(json['product_id']),
      productName: json['product_name'] ?? '-',
      productPrice: Order._parseInt(json['product_price']),
      quantity: Order._parseInt(json['quantity']),
      subtotal: Order._parseInt(json['subtotal']),
    );
  }
}
