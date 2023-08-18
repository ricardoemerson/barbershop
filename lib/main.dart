import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/barbershop_app.dart';
import 'app/core/helpers/env_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvHelper.instance.load();

  runApp(
    const ProviderScope(
      child: BarbershopApp(),
    ),
  );
}
