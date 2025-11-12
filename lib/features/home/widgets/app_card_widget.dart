import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/widgets/rating_widget.dart';

class AppCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final double rating;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  const AppCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.rating = 0.0,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8),
            Expanded(
              child: Center(
                child: Hero(
                  tag: title,
                  child: Image.asset(
                    image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(price, style: const TextStyle(color: Colors.grey)),
                  Gap(8),
                  RatingWidget(),

                  Gap(8),
                  ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text('Add to Cart'),
                  ),
                  Gap(8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
