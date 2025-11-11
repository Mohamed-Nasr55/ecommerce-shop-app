import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/cart/cart_model.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<int>(
          valueListenable: CartModel().cartCountNotifier,
          builder: (context, _, __) {
            final cartItems = CartModel().items;
            double total = 0;
            for (var item in cartItems) {
              total += (item['price'] as double) * (item['quantity'] as int);
            }

            if (cartItems.isEmpty) {
              return const Center(
                child: Text(
                  "cart is empty",
                  style: TextStyle(fontSize: 20, color: AppColors.tealPrimary),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Row(
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
                                    color: Colors.black,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  "\$${item['price']}",
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
                                  CartModel().removeItemQuantity(item);
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.tealPrimary,
                                ),
                              ),
                              Text("${item['quantity']}"),
                              IconButton(
                                onPressed: () {
                                  CartModel().addItemQuantity(item);
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
                const Divider(color: Colors.grey),
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
                      "\$ ${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.black,
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
                ),
                const Gap(20),
              ],
            );
          },
        ),
      ),
    );
  }
}
