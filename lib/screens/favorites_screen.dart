import 'package:dundaser/models/bottom_navigation.dart';
import 'package:dundaser/widgets/favorites.dart';
import 'package:dundaser/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() {
    return _FavoriteScreenState();
  }
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  //Rendering a screen to show all the reviews a user has added to favorites
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: const CustomAppBar(title: 'Your Favorites'),
      body: const FavoritesList(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
