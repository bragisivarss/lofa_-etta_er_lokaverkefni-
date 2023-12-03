import 'dart:io';

import 'package:dundaser/models/drink.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrinksNotifier extends StateNotifier<List<Drink>> {
  UserDrinksNotifier() : super(const []);

  void addPlace({
    required String title,
    required String about,
    required double rating,
    required File image,
  }) {
    final newDrink = Drink(
      title: title,
      about: about,
      rating: rating,
      image: image,
    );
    state = [newDrink, ...state];
  }
}

final userDrinksProvide =
    StateNotifierProvider<UserDrinksNotifier, List<Drink>>(
  (ref) => UserDrinksNotifier(),
);
