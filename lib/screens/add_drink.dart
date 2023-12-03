import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dundaser/widgets/image_input.dart';

class AddDrinkScreen extends StatefulWidget {
  const AddDrinkScreen({super.key});

  @override
  State<AddDrinkScreen> createState() {
    return _AddDrinkScreen();
  }
}

class _AddDrinkScreen extends State<AddDrinkScreen> {
  //var category = Categories.alchahol;
  var isLoading = false;
  File? takenPicture;
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _ratingController = TextEditingController();

  void _saveReview() async {
    setState(() {
      isLoading = true;
    });

    final enteredName = _nameController.text;
    final enteredAbout = _aboutController.text;
    final enteredRating = _ratingController.text;

    var fixedRating = double.tryParse(enteredRating);

    if (fixedRating == null) {
      return;
    }

    if (enteredName.isEmpty || enteredAbout.isEmpty || takenPicture == null) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;

    final CollectionReference drinksCollection =
        FirebaseFirestore.instance.collection('drinks');

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('drink_images')
        // ignore: unnecessary_brace_in_string_interps
        .child('${user}${enteredName}${enteredAbout}.jpg');

    await storageRef.putFile(takenPicture!);
    final imageUrl = await storageRef.getDownloadURL();

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    String? uName = userData.data()!['username'] as String;
    String? userId = user.uid;

    Map<String, dynamic> drinkData = {
      'title': enteredName,
      'about': enteredAbout,
      'rating': fixedRating,
      'image': imageUrl,
      'username': uName,
      'userId': userId
    };

    await drinksCollection.add(drinkData);

    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _aboutController.dispose();
    _ratingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        elevation: 5,
        shadowColor: const Color.fromARGB(116, 255, 13, 13),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: const Text(
          'Add a Review',
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: 'Enter The Drink Name',
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(6),
                                bottom: Radius.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          return '';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: _aboutController,
                          maxLength: 200,
                          decoration: InputDecoration(
                            labelText: 'Enter Something About The Drink',
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          validator: (value) {
                            return '';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: _ratingController,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                            labelText: 'Enter Drink Rating 0-10',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8),
                                  bottom: Radius.circular(6)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ImageInput(
                    onPickImage: (image) {
                      takenPicture = image;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: !isLoading
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary),
                          onPressed: _saveReview,
                          icon: Icon(Icons.add,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                          label: Text(
                            'Add Review',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                        )
                      : const CircularProgressIndicator(),
                )
              ],
            ),
          ]),
    );
  }
}
