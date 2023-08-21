import 'package:flutter/material.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeSchedulePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmployeeSchedulePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
