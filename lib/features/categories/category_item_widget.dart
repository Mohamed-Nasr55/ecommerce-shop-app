import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/features/theme/app_colors.dart';

class CategoryItemWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItemWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.tealButtonLight.withOpacity(0.2)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.tealButtonLight
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: AppColors.tealButtonLight),
            const Gap(6),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
