class Shoe {
  final int id;
  final String name;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviews;
  final String image;
  final String description;

  Shoe({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.description,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['oldPrice'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'],
      image: json['image'],
      description: json['description'],
    );
  }
}
