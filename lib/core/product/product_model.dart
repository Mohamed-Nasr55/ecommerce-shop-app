class Product {
  final int id;
  final String title;
  final double price;
  final List<String> images;
  final String description;
  final int categoryId;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
    required this.description,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      categoryId: json['category']['id'],
    );
  }
}
