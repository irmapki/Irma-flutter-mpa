class Product {
  final int id;
  final String name;
  final String? description;
  final int price;
  final int stock;
  final String? category;
  final String? image;
  final int isBestSeller;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    this.category,
    this.image,
    required this.isBestSeller,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: _parseInt(json['price']),
      stock: _parseInt(json['stock']),
      category: json['category'],
      image: json['image'],
      isBestSeller: json['is_best_seller'] ?? 0,
    );
  }

  String get imageUrl => image != null 
    ? 'http://192.168.1.6:8000/storage/products/$image'
    : '';

  // Helper function buat parse int
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

  
