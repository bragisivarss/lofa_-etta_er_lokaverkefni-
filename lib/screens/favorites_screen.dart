import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() {
    return _FavoriteScreenState();
  }
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        elevation: 5,
        shadowColor: const Color.fromARGB(116, 255, 13, 13),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'Your Favorites',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        centerTitle: true,
      ),
    );
  }
}
