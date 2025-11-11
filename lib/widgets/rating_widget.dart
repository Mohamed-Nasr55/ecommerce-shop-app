import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, this.rating = 4.5});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.amber[600], size: 20),
          Icon(Icons.star, color: Colors.amber[600], size: 20),
          Icon(Icons.star, color: Colors.amber[600], size: 20),
          Icon(Icons.star, color: Colors.amber[600], size: 20),
          Icon(Icons.star_half, color: Colors.amber[600], size: 20),
          const Gap(3),
          Text("$rating ", style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
