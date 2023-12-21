import 'package:dundaser/models/categories.dart';
import 'package:dundaser/screens/filters.dart';
import 'package:dundaser/widgets/app_bar.dart';
import 'package:dundaser/widgets/drinks_list.dart';
import 'package:dundaser/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

//This is the homepage of the app where user can navigate to other screens 
//or add a new drink review 
class _MainScreenState extends State<MainScreen> {
  List<Categories>? _selectedCategories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: IconButton(
      //   color: Theme.of(context).colorScheme.primary,
      //   iconSize: 50,
      //   onPressed: () {
      //     Navigator.of(context).push(
      //         MaterialPageRoute(builder: (ctx) => const AddDrinkScreen()));
      //   },
      //   icon: const Icon(Icons.add),
      // ),
      drawer: const MainDrawer(),
      appBar: const CustomAppBar(
        title: 'Home Page',
      ),
      body: DrinksList(selectedCategories: _selectedCategories),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var selectedCategories = await Navigator.of(context).push<List<Categories>?>(
            MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                selectedCategories: _selectedCategories,
                onApplyFilters: (selectedCategories) {
                  setState(() {
                    _selectedCategories = selectedCategories;
                  });
                },
              ),
            ),
          );
          if (selectedCategories != null) {
            setState(() {
              selectedCategories = selectedCategories;
            });
          }
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
