// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'cart_item.dart';
// import 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(const CartState(items: []));

//   // Add item to cart
//   void addItem(CartItem item) {
//     final items = List<CartItem>.from(state.items);
//     final existingIndex = items.indexWhere((i) => i.title == item.title);

//     if (existingIndex != -1) {
//       items[existingIndex].quantity += 1;
//     } else {
//       items.add(item);
//     }

//     emit(CartState(items: items));
//   }

//   // Increase quantity of an item
//   void increaseQuantity(String title) {
//     final items = List<CartItem>.from(state.items);
//     final index = items.indexWhere((i) => i.title == title);
//     if (index != -1) {
//       items[index].quantity += 1;
//       emit(CartState(items: items));
//     }
//   }

//   // Decrease quantity of an item
//   void decreaseQuantity(String title) {
//     final items = List<CartItem>.from(state.items);
//     final index = items.indexWhere((i) => i.title == title);
//     if (index != -1) {
//       if (items[index].quantity > 1) {
//         items[index].quantity -= 1;
//       } else {
//         items.removeAt(index);
//       }
//       emit(CartState(items: items));
//     }
//   }

//   // Clear all items in the cart
//   void clearCart() {
//     emit(const CartState(items: []));
//   }

//   // Total number of items in cart
//   int get totalItems => state.items.fold(0, (sum, item) => sum + item.quantity);

//   // Total price of all items
//   double get total =>
//       state.items.fold(0, (sum, item) => sum + (item.price * item.quantity));
// }


import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: []));

  void addItem(CartItem item) {
    final existingIndex = state.items.indexWhere((i) => i.title == item.title);
    final items = List<CartItem>.from(state.items);

    if (existingIndex != -1) {
      items[existingIndex].quantity += 1;
    } else {
      items.add(item);
    }

    emit(CartState(items: items));
  }

  void increaseQuantity(String title) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.title == title);
    if (index != -1) {
      items[index].quantity += 1;
      emit(CartState(items: items));
    }
  }

  void decreaseQuantity(String title) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.title == title);
    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index].quantity -= 1;
      } else {
        items.removeAt(index);
      }
      emit(CartState(items: items));
    }
  }

  void clearCart() {
    emit(const CartState(items: []));
  }

  int get totalItems => state.items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      state.items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
