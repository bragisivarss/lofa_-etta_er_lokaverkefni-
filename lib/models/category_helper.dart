import 'package:dundaser/models/categories.dart';

Categories convertToCategory(String categoryString) {
  switch (categoryString) {
    case 'alcohol':
      return Categories.alcohol;
    case 'nonAlcoholic':
      return Categories.nonAlcoholic;
    case 'soda':
      return Categories.soda;
    case 'juice':
      return Categories.juice;
    case 'energyDrink':
      return Categories.energyDrink;
    case 'coffe':
      return Categories.coffe;
    default:
      throw ArgumentError('Invalid category string: $categoryString');
  }
}
