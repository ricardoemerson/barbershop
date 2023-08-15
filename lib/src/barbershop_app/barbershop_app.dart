import 'package:barbershop/src/barbershop_app/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbershop',
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
