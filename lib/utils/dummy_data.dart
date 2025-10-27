import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/shoe_model.dart';

class DummyData {
  static Future<List<Shoe>> loadShoes() async {
    final jsonData = await rootBundle.loadString('assets/data/shoes.json');
    final data = json.decode(jsonData) as List;
    return data.map((item) => Shoe.fromJson(item)).toList();
  }
}
