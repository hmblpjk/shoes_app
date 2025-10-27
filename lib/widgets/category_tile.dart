import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.image,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 10,
              right: 10,
              child: Image.asset(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0A2E6B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
