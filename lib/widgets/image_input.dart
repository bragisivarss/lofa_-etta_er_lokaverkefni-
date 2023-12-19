import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  //Callback function
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

//This is used on the add_drink screen
class _ImageInputState extends State<ImageInput> {
  File? takenPicture;

  //Function to take picture to have with review
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 800);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      takenPicture = File(pickedImage.path);
    });

    widget.onPickImage(takenPicture!);
  }

  @override
  Widget build(BuildContext context) {

    //The content wich is shown before the user takes a picture
    Widget content = TextButton.icon(
      icon: Icon(
        Icons.camera,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      label: Text(
        'Add Picture',
        textScaler: const TextScaler.linear(1.5),
        style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onBackground),
      ),
      onPressed: _takePicture,
    );

    //Shows the picture the user has taken and is clickable to take another picture
    if (takenPicture != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          takenPicture!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    //Container wich is used on the add_drink screen which either shows the photo that was taken or 
    //shows an container with an text button to prompt the user to take photo
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 193, 185, 216),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(8)),
        border: Border.all(
          color: const Color.fromARGB(99, 63, 63, 63),
          width: 1,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
