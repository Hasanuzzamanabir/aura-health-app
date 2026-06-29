import 'package:flutter/material.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Meal Plan Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}