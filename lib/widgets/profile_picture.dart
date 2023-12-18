import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final user = FirebaseAuth.instance.currentUser!;
final userData = FirebaseFirestore.instance.collection('users').doc(user.uid).get();

class ChangeProfilePictureDialog extends StatefulWidget {
  const ChangeProfilePictureDialog({super.key});

  @override
  State<ChangeProfilePictureDialog> createState() => _ChangeProfilePictureDialogState();
}

class _ChangeProfilePictureDialogState extends State<ChangeProfilePictureDialog> {
  File? _selectedImage;

  void _saveImage() async {
    if (_selectedImage != null){
    try{
    final storageRef = FirebaseStorage.instance.ref().child('user_images').child(user.uid);
    await storageRef.putFile(_selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();

    await FirebaseFirestore.instance
         .collection('users')
         .doc(user.uid)
         .update({'image_url': imageUrl});
  } catch (e) {
    //Fix this
  }
    }
  }

  void _galleryImage() async {
    final imagePicker = ImagePicker();
    final galleryImage = await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);

    if (galleryImage != null) {
      setState(() {
        _selectedImage = File(galleryImage.path);
      });
    }
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    if (takenImage != null) {
      setState(() {
        _selectedImage = File(takenImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer.withBlue(230),
      title: const Text('Change Profile Picture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _selectedImage != null
              ? CircleAvatar(radius: 50, backgroundImage: FileImage(_selectedImage!))
              : const CircleAvatar(radius: 50, backgroundColor: Color.fromARGB(100, 100, 100, 100)),
          const SizedBox(height: 10),
          const Text('Select or capture a new profile picture'),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: _takePicture,
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: Text(
                  'Take Photo',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _galleryImage,
                icon: Icon(
                  Icons.photo_camera_back_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _saveImage();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
