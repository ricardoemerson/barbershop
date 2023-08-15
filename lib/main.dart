import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/barbershop_app/barbershop_app.dart';

void main() {
  runApp(const ProviderScope(child: BarbershopApp()));
}
