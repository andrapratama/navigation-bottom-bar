import 'package:flutter/material.dart';

class SearchSrceen extends StatelessWidget {
  const SearchSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      backgroundColor: Color.fromARGB(255, 223, 232, 239),
      body: const Center(
        child: Text('Search'),
      ),
    );
  }
}
