import 'package:flutter/material.dart';
import '../models/shoe_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Shoe> _cartItems = [];

  List<Shoe> get cartItems => _cartItems;

  void addToCart(Shoe shoe) {
    _cartItems.add(shoe);
    notifyListeners();
  }

  void removeFromCart(Shoe shoe) {
    _cartItems.remove(shoe);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var shoe in _cartItems) {
      total += shoe.price;
    }
    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
