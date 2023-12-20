import 'package:cloud_firestore/cloud_firestore.dart';

//Model for a single drink
class Drink {
  Drink({
    required this.title,
    required this.about,
    required this.rating,
    required this.image,
    required this.category,
  });

  final String title;
  final String about;
  final double rating;
  final String image;
  final String category;


  //Used in drin_list to be able to navigate to a single drink
  //so im creating a "new" instance of the Drink model with the information im 
  //getting from the firestore data to be able to navigate too the drink the user wants to view
  factory Drink.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Drink(
        title: snapshot['title'],
        image: snapshot['image'],
        about: snapshot['about'],
        rating: snapshot['rating'] as double,
        category: snapshot['category'],
        );
  }
}
