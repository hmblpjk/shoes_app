import 'package:flutter/material.dart';
import '../models/shoe_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Shoe> _wishlistItems = [];

  List<Shoe> get wishlistItems => _wishlistItems;

  void toggleWishlist(Shoe shoe) {
    if (_wishlistItems.contains(shoe)) {
      _wishlistItems.remove(shoe);
    } else {
      _wishlistItems.add(shoe);
    }
    notifyListeners();
  }

  bool isInWishlist(Shoe shoe) {
    return _wishlistItems.contains(shoe);
  }
}
