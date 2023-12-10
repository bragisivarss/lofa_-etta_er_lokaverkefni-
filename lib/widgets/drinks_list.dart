import 'package:dundaser/screens/drink_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/drink.dart';

class DrinksList extends StatelessWidget {
  const DrinksList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('drinks').snapshots(),
      builder: (ctx, drinkSnapshots) {
        if (drinkSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!drinkSnapshots.hasData || drinkSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Reviews Found'),
          );
        }

        if (drinkSnapshots.hasError) {
          return const Center(
            child: Text('Something Went Wrong Try Again Later'),
          );
        }

        final loadedInfo = drinkSnapshots.data!.docs;
        return ListView.builder(
            itemCount: loadedInfo.length,
            itemBuilder: (ctx, index) {
              String title = loadedInfo[index]['title'];
              String image = loadedInfo[index]['image'];
              String about = loadedInfo[index]['about'];
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
                    foregroundImage: NetworkImage(image),
                  ),
                  title: Text(
                    // ignore: unnecessary_brace_in_string_interps
                    'Drink Name: ${title}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                  subtitle: Text(
                    'Review: $preview...view more?',
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DrinkDetailScreen(
                          drink: Drink.fromSnapshot(loadedInfo[index]),
                        ),
                      ),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
