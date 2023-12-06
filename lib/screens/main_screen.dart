//import 'package:dundaser/providers/user_drinks_provider.dart';
import 'package:dundaser/screens/add_drink.dart';
import 'package:dundaser/widgets/drinks_list.dart';
import 'package:dundaser/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
        appBar: AppBar(
          elevation: 5,
          shadowColor: const Color.fromARGB(116, 255, 13, 13),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: true,
          title: Text(
            'AppBar',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        body: const DrinksList());
  }
}
