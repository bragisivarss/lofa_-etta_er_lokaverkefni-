import 'package:dundaser/screens/add_drink.dart';
import 'package:dundaser/widgets/app_bar.dart';
import 'package:dundaser/widgets/drinks_list.dart';
import 'package:dundaser/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: IconButton(
        color: Theme.of(context).colorScheme.primary,
        iconSize: 50,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AddDrinkScreen()));
        },
        icon: const Icon(Icons.add),
      ),
      drawer: const MainDrawer(),
      appBar: const CustomAppBar(
        title: 'Home Page',
      ),
      body: const DrinksList(),
    );
  }
}
