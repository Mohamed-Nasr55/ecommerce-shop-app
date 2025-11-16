import 'package:mysmallshop/core/product/product_model.dart';

class CartItem {
  final String title;
  final String image;
  final double price;
  int quantity;
  CartItem({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
  factory CartItem.fromProduct(Product product) {
    return  
    
    CartItem(
      title: product.title,
      image:
          product.images.isNotEmpty
              ? product.images[0]
              : 'https://placehold.co/640x480',
      price: product.price,
      quantity: 1,
    );
  }
}
