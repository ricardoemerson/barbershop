import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/providers/application_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../data/models/user_model.dart';
import '../widgets/home_header.dart';
import 'home_employee_provider.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userAsync.when(
        loading: () => const AppLoader(),
        error: (error, stackTrace) {
          log('Erro ao carregar página', error: error, stackTrace: stackTrace);

          return const Center(
            child: Text('Erro ao carregar página.'),
          );
        },
        data: (user) {
          final UserModel(:id, :name, :avatar) = user;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader.withoutFilter(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      switch (avatar) {
                        final avatar? => Image(
                            image: NetworkImage(avatar),
                          ),
                        _ => AdvancedAvatar(
                            size: 90,
                            decoration: BoxDecoration(
                              color: AppColors.greyDark,
                              borderRadius: BorderRadius.circular(150),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(3, 3),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            name: name,
                          )
                      },
                      Text(
                        name,
                        style: AppTextStyles.textMedium.copyWith(
                          fontSize: 20,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: context.percentWidth(.7),
                        height: 108,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.grey),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  final totalAsync = ref.watch(getTotalSchedulesTodayProvider(id));

                                  return totalAsync.when(
                                    loading: () => const AppLoader(),
                                    skipLoadingOnRefresh: false,
                                    error: (error, stackTrace) {
                                      log(
                                        'Erro ao carregar total de agendamentos.',
                                        error: error,
                                        stackTrace: stackTrace,
                                      );

                                      return const Center(
                                        child: Text('Erro ao carregar total de agendamentos.'),
                                      );
                                    },
                                    data: (totalSchedule) {
                                      return Text(
                                        '$totalSchedule',
                                        style: AppTextStyles.textSemiBold.copyWith(
                                          fontSize: 26,
                                          color: AppColors.primary,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Text(
                                'Hoje',
                                style: AppTextStyles.textMedium.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 56),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed('/schedule', arguments: user);

                          ref.invalidate(getTotalSchedulesTodayProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('AGENDAR CLIENTE'),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/employee/schedule', arguments: user);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('VER AGENDA'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
