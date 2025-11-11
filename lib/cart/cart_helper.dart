import 'package:flutter/material.dart';

class CartHelper extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere((item) => item['title'] == product['title']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity'] += 1;
    } else {
      _items.add({
        'image': product['image'],
        'title': product['title'],
        'price': double.parse(product['price'].toString().replaceAll(RegExp(r'[^\d.]'), '')),
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  void removeItem(String title) {
    _items.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }

  void increaseQuantity(String title) {
    final index = _items.indexWhere((item) => item['title'] == title);
    if (index != -1) {
      _items[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(String title) {
    final index = _items.indexWhere((item) => item['title'] == title);
    if (index != -1 && _items[index]['quantity'] > 1) {
      _items[index]['quantity'] -= 1;
    } else {
      removeItem(title);
    }
    notifyListeners();
  }

  double get total {
    return _items.fold(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
