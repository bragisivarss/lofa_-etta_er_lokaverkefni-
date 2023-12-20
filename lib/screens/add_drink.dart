import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dundaser/models/categories.dart';
import 'package:dundaser/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dundaser/widgets/image_input.dart';
import 'package:uuid/uuid.dart';

class AddDrinkScreen extends StatefulWidget {
  const AddDrinkScreen({super.key});

  @override
  State<AddDrinkScreen> createState() {
    return _AddDrinkScreen();
  }
}

class _AddDrinkScreen extends State<AddDrinkScreen> {
  var selectedCategory = Categories.alchahol;
  var isLoading = false;
  File? takenPicture;
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _ratingController = TextEditingController();

  //Function to save a review the user has mage
  void _saveReview() async {
    setState(() {
      isLoading = true;
    });

    //The information the user entered in the add review form
    final enteredName = _nameController.text;
    final enteredAbout = _aboutController.text;
    final enteredRating = _ratingController.text;

    var fixedRating = double.tryParse(enteredRating);

    //Just some validation
    if (fixedRating == null) {
      return;
    }

    if (enteredName.isEmpty || enteredAbout.isEmpty || takenPicture == null) {
      return;
    }

    //Accesing wich user is logged in
    final user = FirebaseAuth.instance.currentUser!;

    //Reference to the drinks collection in firestore
    final CollectionReference drinksCollection = FirebaseFirestore.instance.collection('drinks');

    //Creating a path to where the img will be saved in storage
    final storageRef = FirebaseStorage.instance.ref().child('drink_images').child('$user$enteredName$enteredAbout.jpg');

    //Saving the img too the path prev created
    await storageRef.putFile(takenPicture!);
    final imageUrl = await storageRef.getDownloadURL();

    //Reference to the specific user to associate the drink review to the user who is logged in
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    //Accesing the username
    String? uName = userData.data()!['username'] as String;
    //Accesing the user id
    String? userId = user.uid;
    //Creating an id for the review
    const uuid = Uuid();
    String reviewId = uuid.v4();

    //Creating a map to push to the db
    Map<String, dynamic> drinkData = {
      'title': enteredName,
      'about': enteredAbout,
      'rating': fixedRating,
      'image': imageUrl,
      'username': uName,
      'userId': userId,
      'itemId': reviewId,
      'category': selectedCategory.toString().split('.').last,
    };

    //Pushing the data to db
    await drinksCollection.add(drinkData);

    setState(() {
      Navigator.of(context).pop();
    });
  }

//Disposing the controllers so they dont eat up memory
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _aboutController.dispose();
    _ratingController.dispose();
  }

//Rendering a screen where user can add information about a drink
//they want to create a review of
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: const CustomAppBar(title: 'Add Review'),
      body: ListView(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20), children: [
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
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(6), bottom: Radius.circular(8)),
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
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
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
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        labelText: 'Enter Drink Rating 0-10',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8), bottom: Radius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DropdownButtonFormField<Categories>(
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(100, 100, 100, 100),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                value: selectedCategory,
                items: Categories.values.map((category) {
                  return DropdownMenuItem<Categories>(
                    value: category,
                    child: Text(category.toString().split('.').last, 
                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                      onPressed: _saveReview,
                      icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      label: Text(
                        'Add Review',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
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
