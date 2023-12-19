import 'package:dundaser/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  //Safety screen so if a user logs in and it takes sometime for the authentication
  //to finnish the user does not have the chance to try send a req again
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Loading...'),
      body: Center(
        child: Text('Loading..'),
      ),
    );
  }
}
