import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsernameChangeDialog extends StatefulWidget {
  const UsernameChangeDialog(
      {super.key, required this.currentUsername, required this.onUpdate});

  final Function(String) onUpdate;

  final String currentUsername;

  @override
  UsernameChangeDialogState createState() => UsernameChangeDialogState();
}

class UsernameChangeDialogState extends State<UsernameChangeDialog> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.currentUsername);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change Username',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'New Username'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;

            String newUsername = _usernameController.text;

            widget.onUpdate(newUsername);

            try {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .update({
                'username': _usernameController.text,
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            } catch (e) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error updating username')),
              );
            }
          },
          child: Text(
            'Save',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog without updating
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      ],
    );
  }
}
