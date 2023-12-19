import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  //Setting the constraints on the appbar heigh
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//AppBar wich is used on a few places throughout the app 
//removing duplication
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      shadowColor: const Color.fromARGB(116, 255, 13, 13),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
