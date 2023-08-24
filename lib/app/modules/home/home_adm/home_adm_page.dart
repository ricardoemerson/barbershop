import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/providers/application_providers.dart';
import '../../../core/widgets/app_loader.dart';
import '../widgets/home_header.dart';
import 'home_adm_state.dart';
import 'home_adm_vm.dart';
import 'widgets/home_employee_tile.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAdmAsyncValue = ref.watch(homeAdmVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/employee/register');

          ref.invalidate(getMeProvider);
          ref.invalidate(homeAdmVmProvider);
        },
        child: PhosphorIcon(
          PhosphorIcons.fill.plusCircle,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: homeAdmAsyncValue.when(
        data: (homeState) {
          final HomeAdmState(:employees) = homeState;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: employees.length,
                  (context, index) {
                    final employee = employees[index];

                    return HomeEmployeeTile(employee: employee);
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar colaboradores', error: error, stackTrace: stackTrace);

          return const Center(
            child: Text('Erro ao carregar colaboradores.'),
          );
        },
        loading: () => const AppLoader(),
      ),
    );
  }
}
