import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/barbershop_app.dart';
import 'src/core/helpers/env_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvHelper.instance.load();

  runApp(
    const ProviderScope(
      child: BarbershopApp(),
    ),
  );
}
