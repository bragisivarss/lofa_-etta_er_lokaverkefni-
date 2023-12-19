import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class UserImagePicker extends StatefulWidget {
//   const UserImagePicker({super.key, required this.onPickImage});

//   //Callback function
//   final void Function(File pickedImage) onPickImage;

//   @override
//   State<UserImagePicker> createState() {
//     return _UserImagePickerState();
//   }
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   File? _pickedImageFile;

//   //Function that is used in the auth screen so the user is able to take profile picture
//   //and have it associated with his/hers account
//   void _pickImage() async {
//     final pickedImage = await ImagePicker()
//         .pickImage(source: ImageSource.camera, maxWidth: 400);

//     if (pickedImage == null) {
//       return;
//     }
//     setState(() {
//       _pickedImageFile = File(pickedImage.path);
//     });

//     widget.onPickImage(_pickedImageFile!);
//   }

//   //Rendering a empty circle avatar before user takes photo 
//   //or shows a preview of the photo the user has taken
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundColor: Colors.blueGrey,
//           foregroundImage:
//               _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
//         ),
//         TextButton.icon(
//           onPressed: _pickImage,
//           icon: const Icon(Icons.image),
//           label: Text(
//             'Add Image',
//             style: TextStyle(color: Theme.of(context).colorScheme.primary),
//           ),
//         ),
//       ],
//     );
//   }
// }
