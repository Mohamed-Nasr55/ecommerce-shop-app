import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';
import 'package:mysmallshop/features/profile/screens/payment_method_screen.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final items = state.items;
          final total = state.total;
          if (items.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.image,
                            
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "\$${item.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .decreaseQuantity(item.title),
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                "${item.quantity}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed:
                                    () => context
                                        .read<CartCubit>()
                                        .increaseQuantity(item.title),
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: "Checkout",
                  height: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PaymentMethodScreen(),
                      ),
                    );
                  },
                ),
                const Gap(10),
              ],
            ),
          );
        },
      ),
    );
  }
}
