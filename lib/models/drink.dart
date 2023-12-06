import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String image;

  factory Drink.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Drink(
        title: snapshot['title'],
        image: snapshot['image'],
        about: snapshot['about'],
        rating: snapshot['rating'] as double);
  }
}
