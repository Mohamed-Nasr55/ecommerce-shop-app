import 'package:flutter/foundation.dart';

class CartModel {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final List<Map<String, dynamic>> _items = [];

  final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  List<Map<String, dynamic>> get items => _items;

  double get total {
    double sum = 0;
    for (var item in _items) {
      sum += (item['price'] as double) * (item['quantity'] as int);
    }
    return sum;
  }

  void _updateCartCount() {
    int count = 0;
    for (var item in _items) {
      count += item['quantity'] as int;
    }
    cartCountNotifier.value = count;
  }

  void addItem(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['title'] == product['title']);
    if (index != -1) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({...product});
    }
    _updateCartCount();
  }

  void addItemQuantity(Map<String, dynamic> item) {
    final index = _items.indexWhere((i) => i['title'] == item['title']);
    if (index != -1) {
      _items[index]['quantity'] += 1;
      _updateCartCount();
    }
  }

  void removeItemQuantity(Map<String, dynamic> item) {
    final index = _items.indexWhere((i) => i['title'] == item['title']);
    if (index != -1) {
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity'] -= 1;
      } else {
        _items.removeAt(index);
      }
      _updateCartCount();
    }
  }
}
