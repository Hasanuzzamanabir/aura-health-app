import 'package:flutter/material.dart';

class AiChat extends StatelessWidget {
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Coach Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the AI Coach Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}