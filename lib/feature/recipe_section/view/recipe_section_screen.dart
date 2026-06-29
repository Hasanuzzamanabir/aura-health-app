import 'package:flutter/material.dart';

class RecipeSectionScreen extends StatelessWidget {
  const RecipeSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Recipes Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}