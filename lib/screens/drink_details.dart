import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/drink.dart';
import 'package:dundaser/screens/auth.dart';
import 'package:dundaser/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Drink detail screen for reviewing information about drink or add/remove drink from favorites

class DrinkDetailScreen extends StatelessWidget {
  const DrinkDetailScreen({
    super.key,
    required this.drink,
  });

  final Drink drink;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    void addToFavorites() async {
      CollectionReference favoritesCollection =
          db.collection('users').doc(user.uid).collection('favorites');

      await favoritesCollection.add({
        'title': drink.title,
        'about': drink.about,
        'rating': drink.rating,
        'image': drink.image,
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        shadowColor: const Color.fromARGB(116, 255, 13, 13),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          drink.title,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 400,
              child: ListView(
                padding: const EdgeInsets.only(top: 25, left: 5),
                children: [
                  Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.black.withOpacity(0.4),
                              width: 1),
                        ),
                        child: Text(
                          'Drink Name',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        drink.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.black.withOpacity(0.4),
                              width: 1),
                        ),
                        child: Text(
                          'Drink Review',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        drink.about,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.black.withOpacity(0.4),
                              width: 1),
                        ),
                        child: Text(
                          'Drink Rating',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        drink.rating.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 250,
                        width: 230,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              drink.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3,
                              ) +
                              Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                width: 2,
                              ) +
                              Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      OverflowBar(
                        spacing: 1,
                        children: [
                          ElevatedButton.icon(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(10),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                            ),
                            onPressed: addToFavorites,
                            icon: Icon(
                              Icons.star_border_purple500,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 20,
                            ),
                            label: Text(
                              'Add to Favorites',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                            ),
                          ),
                          MaterialButton(
                              elevation: 10,
                              color: Theme.of(context).colorScheme.background,
                              shape: const UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              onPressed: () {},
                              child: const Text('Remove From Favorites'))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        elevation: 10,
        backgroundColor:
            Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
        onTap: (int index) {
          if (index == 0) {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (ctx) => const AuthScreen(),
                ),
                (route) => false);
          } else if (index == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const MainScreen()));
          }
        },
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onBackground),
        unselectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onBackground),
        selectedItemColor: Theme.of(context)
            .colorScheme
            .onBackground, // Color for selected item
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        items: [
          BottomNavigationBarItem(
            label: 'Exit',
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
