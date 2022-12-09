import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 232, 239),
      body: const Center(
        child: Text('Post'),
      ),
    );
  }
}
