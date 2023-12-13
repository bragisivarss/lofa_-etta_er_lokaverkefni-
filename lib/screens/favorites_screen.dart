import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/bottom_navigation.dart';
import 'package:dundaser/models/drink.dart';
import 'package:dundaser/screens/drink_details.dart';
import 'package:dundaser/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;

    Future<List<Map<String, dynamic>>> getFavorites() async {
      CollectionReference favoritesCollection =
          db.collection('users').doc(user.uid).collection('favorites');

      QuerySnapshot querySnapshot = await favoritesCollection.get();

      return querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }

    return FutureBuilder(
      future: getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No favorites found.');
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            appBar: const CustomAppBar(title: 'Your Favorites'),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String about = snapshot.data![index]['about'];
                String preview = about.substring(0, 5);
                final isFirstItem = index == 0;

                return DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: isFirstItem
                          ? const BorderSide(width: 1)
                          : BorderSide.none,
                      bottom: const BorderSide(width: 1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        top: 15, left: 15, bottom: 20, right: 10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                      foregroundImage:
                          NetworkImage(snapshot.data![index]['image']),
                    ),
                    title: Text(
                      snapshot.data![index]['title'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    subtitle: Text(
                      'Review: $preview...View More?',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DrinkDetailScreen(
                            drink: Drink.fromSnapshots(snapshot.data![index]),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            bottomNavigationBar: const BottomNavigation(),
          );
        }
      },
    );
  }
}
