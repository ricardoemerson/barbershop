import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeAdmPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeAdmPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
