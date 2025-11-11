import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/cart/cart_model.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartModel cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white),
      body: ValueListenableBuilder<int>(
        valueListenable: cart.cartCountNotifier,
        builder: (context, _, __) {
          final cartItems = cart.items;
          double total = cart.total;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                "Cart is Empty ",
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
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  " ${item['price']}",
                                  style: const TextStyle(
                                    color: AppColors.tealPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (item['quantity'] > 1) {
                                      item['quantity'] -= 1;
                                    } else {
                                      cart.removeItem(index);
                                    }
                                    cart.cartCountNotifier.value =
                                        cart.cartCountNotifier.value - 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.tealPrimary,
                                ),
                              ),
                              Text(
                                "${item['quantity']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    item['quantity'] += 1;
                                    cart.cartCountNotifier.value =
                                        cart.cartCountNotifier.value + 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.tealPrimary,
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
                        color: AppColors.tealPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: "Checkout",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Proceeding to checkout..."),
                      ),
                    );
                  },
                  height: 50,
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    );
  }
}
