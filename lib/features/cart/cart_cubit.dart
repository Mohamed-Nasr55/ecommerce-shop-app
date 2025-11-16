import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: []));

  void addItem(CartItem item) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.title == item.title);

    if (index != -1) {
      final updatedItem = CartItem(
        title: items[index].title,
        image: items[index].image,
        price: items[index].price,
        quantity: items[index].quantity + 1,
      );
      items[index] = updatedItem;
    } else {
      items.add(item);
    }

    emit(CartState(items: items));
  }

  void increaseQuantity(String title) {
    final items = state.items.map((item) {
      if (item.title == title) {
        return CartItem(
          title: item.title,
          image: item.image,
          price: item.price,
          quantity: item.quantity + 1,
        );
      }
      return item;
    }).toList();
    emit(CartState(items: items));
  }

  void decreaseQuantity(String title) {
    final items = state.items.map((item) {
      if (item.title == title) {
        return CartItem(
          title: item.title,
          image: item.image,
          price: item.price,
          quantity: item.quantity - 1,
        );
      }
      return item;
    }).where((item) => item.quantity > 0).toList();

    emit(CartState(items: items));
  }

  void clearCart() => emit(const CartState(items: []));

  int get totalItems => state.items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      state.items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
