import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfilePictureDialog extends StatefulWidget {
  const ChangeProfilePictureDialog({super.key});

  @override
  State<ChangeProfilePictureDialog> createState() =>
      _ChangeProfilePictureDialogState();
}

class _ChangeProfilePictureDialogState
    extends State<ChangeProfilePictureDialog> {
  File? _selectedImage;

  void _galleryImage() async {
    final imagePicker = ImagePicker();
    final galleryImage = await imagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 400);

    if (galleryImage != null) {
      setState(() {
        _selectedImage = File(galleryImage.path);
      });
    }
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 400);

    if (takenImage != null) {
      setState(() {
        _selectedImage = File(takenImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Theme.of(context).colorScheme.secondaryContainer.withBlue(230),
      title: const Text('Change Profile Picture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _selectedImage != null
              ? CircleAvatar(
                  radius: 50, backgroundImage: FileImage(_selectedImage!))
              : const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(100, 100, 100, 100)),
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
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
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
            
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// class ProfilePictureScreen extends StatefulWidget {
//   const ProfilePictureScreen({super.key});

//   @override
//   State<ProfilePictureScreen> createState() {
//     return _ProfilePictureScreenState();
//   }
// }

// class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'Change Profile Picture'),
//       backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//       body: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           height: 250,
//           width: double.infinity,
//           decoration: ShapeDecoration(
//             shape: Border.all(
//                   color: Theme.of(context).colorScheme.primary,
//                   width: 3,
//                 ) +
//                 Border.all(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                   width: 2,
//                 ) +
//                 Border.all(
//                   color: Theme.of(context).colorScheme.secondary,
//                   width: 1,
//                 ),
//           ),
//           alignment: Alignment.center,
//           child: TextButton.icon(
//             icon: const Icon(Icons.camera),
//             label: const Text('Take Picture'),
//             onPressed: () {},
//           ),
//         ),
      
//     );
//   }
// }
