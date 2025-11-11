import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/cart/cart_model.dart';
import 'package:mysmallshop/cart/cart_screen.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';
import 'package:mysmallshop/widgets/rating_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String description;
  final double rating;

  const ProductDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
        title: Text("$title"),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: CartModel().cartCountNotifier,
            builder: (context, count, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartScreen()),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
            const Gap(10),
            RatingWidget(rating: rating),
            const Gap(20),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const Gap(40),
            CustomElevatedButton(
              text: "Add to Cart",
              icon: Icons.shopping_cart,
              onPressed: () {
                CartModel().addItem({
                  'image': image,
                  'title': title,
                  'price': double.parse(price.replaceAll('\$', '')),
                  'quantity': 1,
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("$title added to cart")));
              },
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
