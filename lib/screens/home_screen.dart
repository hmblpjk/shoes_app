import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/providers/cart_provider.dart';
import 'package:shoes_app/utils/page_transition.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_card.dart';
import '../utils/dummy_data.dart';
import '../models/shoe_model.dart';
import '../screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Shoe>> shoesFuture;

  @override
  void initState() {
    super.initState();
    shoesFuture = DummyData.loadShoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF0A2E6B)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF0A2E6B),
                ),
                // indikator jumlah item
                Positioned(
                  right: -4,
                  top: -4,
                  child: Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return cart.cartItems.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  cart.cartItems.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                AppPageTransition.slide(const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome To StepHub!\n50% Off",
                style: TextStyle(
                  color: Color(0xFF0A2E6B),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),

              // Banner Slider
              const BannerSlider(),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Best sellers",
                    style: TextStyle(
                      color: Color(0xFF0A2E6B),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "view all >",
                    style: TextStyle(color: Color(0xFF0A2E6B), fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Product List
              FutureBuilder<List<Shoe>>(
                future: shoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text("Error loading shoes");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No products found");
                  }

                  final shoes = snapshot.data!;
                  return SizedBox(
                    height: 280,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: shoes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return ProductCard(shoe: shoes[index]);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
