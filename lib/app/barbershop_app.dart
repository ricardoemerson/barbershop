import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:flutter/material.dart';

import 'core/contexts/global_context.dart';
import 'core/theme/theme.dart';
import 'core/widgets/app_loader.dart';
import 'modules/auth/login/login_page.dart';
import 'modules/auth/register/barbershop_register/barbershop_register_page.dart';
import 'modules/auth/register/user_register/user_register_page.dart';
import 'modules/employee/employee_register/employee_register_page.dart';
import 'modules/home/home_adm/home_adm_page.dart';
import 'modules/home/home_employee/home_employee_page.dart';
import 'modules/splash/splash_page.dart';

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
          navigatorKey: GlobalContext.instance.navigatorKey,
          routes: {
            '/': (context) => const SplashPage(),
            '/auth/login': (context) => const LoginPage(),
            '/auth/register/user': (context) => const UserRegisterPage(),
            '/auth/register/barbershop': (context) => const BarbershopRegisterPage(),
            '/home/adm': (context) => const HomeAdmPage(),
            '/home/employee': (context) => const HomeEmployeePage(),
            '/employee/register': (context) => const EmployeeRegisterPage(),
          },
        );
      },
    );
  }
}
