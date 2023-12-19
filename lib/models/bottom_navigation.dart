import 'package:dundaser/screens/auth.dart';
import 'package:dundaser/screens/favorites_screen.dart';
import 'package:dundaser/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() {
    return _BottomNavigation();
  }
}

//Bottom navigation bar wich is used on a few screens inside the app 
//created a seperate file to keep code a little bit cleaner and remove duplication
class _BottomNavigation extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const FavoriteScreen(),
            ),
          );
        } else if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const MainScreen(),
            ),
          );
        }
      },
      selectedLabelStyle:
          TextStyle(color: Theme.of(context).colorScheme.onBackground),
      unselectedLabelStyle:
          TextStyle(color: Theme.of(context).colorScheme.onBackground),
      selectedItemColor:
          Theme.of(context).colorScheme.onBackground, // Color for selected item
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
          label: 'Favorites!',
          icon: Icon(
            Icons.star_border,
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
    );
  }
}
