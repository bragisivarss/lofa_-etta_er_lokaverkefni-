import 'package:dundaser/models/categories.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
    required this.onApplyFilters,
    this.selectedCategories,
  });
  
  final List<Categories>? selectedCategories;
  final Function(List<Categories>?) onApplyFilters;

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  List<Categories> _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _selectedCategories = widget.selectedCategories ?? [];
  }

   void _updateSelectedCategories(Categories category, bool value) {
    setState(() {
      if (value) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar( elevation: 5,
      shadowColor: const Color.fromARGB(116, 255, 13, 13),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      centerTitle: true,
      title: Text('Filters',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
      ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.onApplyFilters(_selectedCategories.isNotEmpty
                  ? List.from(_selectedCategories)
                  : null);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          CheckboxListTile(
            title: const Text('Alcoholic'),
            value: _selectedCategories.contains(Categories.alcohol),
            onChanged: (value) {
              _updateSelectedCategories(Categories.alcohol, value ?? false);
            },
          ),
          CheckboxListTile(
            title: const Text('Non-Alcoholic'),
            value: _selectedCategories.contains(Categories.nonAlcoholic),
            onChanged: (value) {
              _updateSelectedCategories(Categories.nonAlcoholic, value ?? false);
            },
          ),
          //alcohol, nonAlcoholic, soda, juice, energyDrink, coffe
          CheckboxListTile(
            title: const Text('Soda'),
            value: _selectedCategories.contains(Categories.soda),
            onChanged: (value) {
              _updateSelectedCategories(Categories.soda, value ?? false);
            },
          ),
          CheckboxListTile(
            title: const Text('Juice'),
            value: _selectedCategories.contains(Categories.juice),
            onChanged: (value) {
              _updateSelectedCategories(Categories.juice, value ?? false);
            },
          ),
          CheckboxListTile(
            title: const Text('Energy Drink'),
            value: _selectedCategories.contains(Categories.energyDrink),
            onChanged: (value) {
              _updateSelectedCategories(Categories.energyDrink, value ?? false);
            },
          ),
          CheckboxListTile(
            title: const Text('Coffe'),
            value: _selectedCategories.contains(Categories.coffe),
            onChanged: (value) {
              _updateSelectedCategories(Categories.coffe, value ?? false);
            },
          ),
        ],
      ),
    );
  }
}