import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';
import 'package:mysmallshop/widgets/rating_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String description;

  const ProductDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required double rating,
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
        title: const Text("Product Details"),
        centerTitle: true,
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

            RatingWidget(),

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
            const Gap(150),
            CustomElevatedButton(
              text: "Add to Cart",
              icon: Icons.shopping_cart,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
