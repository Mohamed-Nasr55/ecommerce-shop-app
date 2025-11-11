import 'package:flutter/material.dart';

class CartModel {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final List<Map<String, dynamic>> items = [];
  final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  void addItem(Map<String, dynamic> product) {
    final existingIndex =
        items.indexWhere((item) => item['title'] == product['title']);

    if (existingIndex != -1) {
      items[existingIndex]['quantity'] += 1;
    } else {
      items.add({
        ...product,
        'quantity': 1,
      });
    }
    _updateCartCount();
  }

  void removeItem(int index) {
    items.removeAt(index);
    _updateCartCount();
  }

  void _updateCartCount() {
    int totalCount = 0;
    for (var item in items) {
      totalCount += item['quantity'] as int;
    }
    cartCountNotifier.value = totalCount;
  }

  double get total {
    double total = 0.0;
    for (var item in items) {
      final priceString = (item['price'] as String)
          .replaceAll('\$', '')
          .replaceAll(',', '')
          .trim();
      total += (double.tryParse(priceString) ?? 0) * (item['quantity'] as int);
    }
    return total;
  }
}
