import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'core/widgets/app_loader.dart';
import 'features/auth/login/login_page.dart';
import 'features/splash/splash_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const AppLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Barbershop',
          theme: AppTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          routes: {
            '/': (context) => const SplashPage(),
            '/auth/login': (context) => const LoginPage(),
          },
        );
      },
    );
  }
}
