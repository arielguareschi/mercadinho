import 'package:flutter/material.dart';
import 'package:mercadinho/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? CustomColors.customSwatchColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : CustomColors.customConstrastColor,
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 16 : 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
