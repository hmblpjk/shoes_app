import 'package:flutter/material.dart';
import '../widgets/category_tile.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      "title": "Men’s Shoes",
      "image": "assets/images/img(2).png",
      "color": Color(0xFFB3E5FC)
    },
    {
      "title": "Women’s Shoes",
      "image": "assets/images/img(3).png",
      "color": Color(0xFFFFF9C4)
    },
    {
      "title": "Kids’ Shoes",
      "image": "assets/images/flexfit.png",
      "color": Color(0xFFC8E6C9)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(
            color: Color(0xFF0A2E6B),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // dua kolom
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryTile(
              title: category['title'],
              image: category['image'],
              color: category['color'],
              onTap: () {
                // nanti diarahkan ke halaman shop sesuai kategori
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Opening ${category['title']}"),
                    duration: const Duration(milliseconds: 600),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
