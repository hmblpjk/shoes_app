import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/shoe_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Shoe shoe;
  const ProductDetailScreen({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A2E6B)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.favorite_border, color: Color(0xFF0A2E6B)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Gambar Produk
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    shoe.image,
                    width: 280,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 🏷️ Nama & Harga
              Text(
                shoe.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2E6B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "\$${shoe.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber.shade700, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "${shoe.rating} (${shoe.reviews} reviews)",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 📏 Pilihan Ukuran
              const Text(
                "Select Size",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2E6B),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                children: [39, 40, 41, 42, 43, 44]
                    .map(
                      (size) => ChoiceChip(
                        label: Text(size.toString()),
                        selectedColor: const Color(0xFF0A2E6B),
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        selected: false,
                        onSelected: (_) {},
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),

              // 🎨 Pilihan Warna
              const Text(
                "Select Color",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0A2E6B),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildColorCircle(Colors.black),
                  _buildColorCircle(Colors.blue),
                  _buildColorCircle(Colors.orange),
                  _buildColorCircle(Colors.redAccent),
                  _buildColorCircle(Colors.grey),
                ],
              ),
              const SizedBox(height: 24),

              // 📝 Deskripsi Produk
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF0A2E6B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                shoe.description,
                style: const TextStyle(color: Colors.black54, height: 1.4),
              ),
              const SizedBox(height: 32),

              // 🛒 Tombol Add to Cart
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2E6B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    final cart = Provider.of<CartProvider>(
                      context,
                      listen: false,
                    );
                    cart.addToCart(shoe);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${shoe.name} added to cart!"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },

                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
    );
  }
}
