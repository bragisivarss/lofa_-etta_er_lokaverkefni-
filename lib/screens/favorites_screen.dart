import 'package:cloud_firestore/cloud_firestore.dart';
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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]['title']),
                subtitle: Text(snapshot.data![index]['about']),
              );
            },
          );
        }
      },
    );
  }
}
//     }); Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//       appBar: AppBar(
//         elevation: 5,
//         shadowColor: const Color.fromARGB(116, 255, 13, 13),
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//         title: Text(
//           'Your Favorites',
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.onSecondaryContainer),
//         ),
//         centerTitle: true,
//       ),
//     );
//   }
// }
