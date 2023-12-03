import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? takenPicture;

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
