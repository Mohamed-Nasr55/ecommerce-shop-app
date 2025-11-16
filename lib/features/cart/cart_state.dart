import 'package:equatable/equatable.dart';
import 'cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  const CartState({required this.items});
  double get total =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  @override
  List<Object> get props => [items];
}
