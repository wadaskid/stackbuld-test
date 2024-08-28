class Product {
  String id;
  String name;
  String description;
  double price;
  String category;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'],
      description: data['description'],
      price: data['price'].toDouble(),
      category: data['category'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
