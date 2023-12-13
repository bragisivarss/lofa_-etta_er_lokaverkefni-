import 'package:dundaser/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
