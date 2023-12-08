import 'package:dundaser/models/drink.dart';
import 'package:dundaser/screens/auth.dart';
import 'package:dundaser/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Drink detail screen for reviewing information about drink or add/remove drink from favorites

class DrinkDetailScreen extends ConsumerWidget {
  const DrinkDetailScreen({
    super.key,
    required this.drink,
  });

  final Drink drink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Opacity(
            opacity: 0.7,
            child: Image.network(
              drink.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          ListView(
            padding: const EdgeInsets.only(top: 20, left: 5),
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                      'Review Made By',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '**NAME**',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  OverflowBar(
                    spacing: 12,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.primaryContainer),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                        onPressed: () {},
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
                      // const SizedBox(width: 10),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
