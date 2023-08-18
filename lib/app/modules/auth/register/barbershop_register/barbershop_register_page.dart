import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarbershopRegisterPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BarbershopRegisterPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
