import 'package:flutter/material.dart';

class HomeEmployeePage extends StatelessWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeEmployeePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeEmployeePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
