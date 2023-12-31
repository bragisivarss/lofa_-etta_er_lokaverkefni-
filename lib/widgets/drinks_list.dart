import 'package:dundaser/models/categories.dart';
import 'package:dundaser/models/category_helper.dart';
import 'package:dundaser/screens/drink_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/drink.dart';

class DrinksList extends StatelessWidget {
  const DrinksList({super.key, this.selectedCategories});
  final List<Categories>? selectedCategories;

//Rendering all the reviews (used on main_screen) created in a seperate 
//folder to keep code nicer and easier to manage and understand
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

        List<DocumentSnapshot> filteredDrinks = selectedCategories != null
    ? loadedInfo.where((drink) {
        String categoryString = drink['category']; // Replace 'category' with the actual field name
        Categories category = convertToCategory(categoryString);
        return selectedCategories!.contains(category);
      }).toList()
    : List.from(loadedInfo);

        return ListView.builder(
          itemCount: filteredDrinks.length,
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
                  'Drink Name: $title',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                subtitle: Text(
                  'Review: $preview...view more?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                onTap: () {
                  String documentId = loadedInfo[index].id;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => DrinkDetailScreen(
                        drink: Drink.fromSnapshot(loadedInfo[index]),
                        documentId: documentId,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
