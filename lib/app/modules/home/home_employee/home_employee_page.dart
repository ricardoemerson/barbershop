import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/user_avatar.dart';
import '../widgets/home_header.dart';

class HomeEmployeePage extends StatelessWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                  const UserAvatar(),
                  Text(
                    'Nome e Sobrenome',
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
                          Text(
                            '5',
                            style: AppTextStyles.textSemiBold
                                .copyWith(fontSize: 26, color: AppColors.primary),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('AGENDAR CLIENTE'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
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
      ),
    );
  }
}
