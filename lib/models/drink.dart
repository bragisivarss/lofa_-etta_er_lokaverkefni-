import 'dart:io';

//Model for drink so a single drink

class Drink {
  Drink({
    required this.title,
    required this.about,
    required this.rating,
    required this.image,
  });

  final String title;
  final String about;
  final double rating;
  final File image;

  factory Drink.fromFirestore(Map<String, dynamic> data) {
    return Drink(
      title: data['title'] ?? '',
      about: data['about'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      image: File(data['image'] ?? ''),
      // Add more parameters for additional fields
    );
  }
}
