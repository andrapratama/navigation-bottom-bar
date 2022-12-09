import 'package:flutter/material.dart';

class ProfileSrceen extends StatelessWidget {
  const ProfileSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      backgroundColor: Color.fromARGB(255, 223, 232, 239),
      body: const Center(
        child: Text('Profile'),
      ),
    );
  }
}
