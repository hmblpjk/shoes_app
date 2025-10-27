import 'package:flutter/material.dart';
import 'package:shoes_app/screens/product_detail_screen.dart';
import 'package:shoes_app/utils/page_transition.dart';
import '../models/shoe_model.dart';
import '../utils/dummy_data.dart';
import '../widgets/product_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<List<Shoe>> shoesFuture;
  String _sortOption = 'Lowest Price';

  @override
  void initState() {
    super.initState();
    shoesFuture = DummyData.loadShoes();
  }

  void _showSortPopup() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sort by",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF0A2E6B),
                ),
              ),
              const SizedBox(height: 12),
              _buildSortOption('Lowest Price'),
              _buildSortOption('Highest Price'),
              _buildSortOption('Best Rating'),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _sortOption = selected;
      });
    }
  }

  Widget _buildSortOption(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF0A2E6B)),
      ),
      trailing: _sortOption == title
          ? const Icon(Icons.check, color: Colors.amber)
          : null,
      onTap: () => Navigator.pop(context, title),
    );
  }

  List<Shoe> _sortShoes(List<Shoe> shoes) {
    switch (_sortOption) {
      case 'Highest Price':
        shoes.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Best Rating':
        shoes.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        shoes.sort((a, b) => a.price.compareTo(b.price));
    }
    return shoes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Shop",
          style: TextStyle(
            color: Color(0xFF0A2E6B),
            fontWeight: FontWeight.w600,
          ),   
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Color(0xFF0A2E6B)),
            onPressed: _showSortPopup,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Shoe>>(
          future: shoesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading products"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            var shoes = snapshot.data!;
            shoes = _sortShoes(shoes);

            return GridView.builder(
              itemCount: shoes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return ProductCard(shoe: shoes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
