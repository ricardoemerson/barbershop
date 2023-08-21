import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/config/config.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/providers/application_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_loader.dart';
import '../home_adm/home_adm_vm.dart';

class HomeHeader extends ConsumerWidget {
  final bool hideFilter;

  const HomeHeader({super.key}) : hideFilter = false;
  const HomeHeader.withoutFilter({super.key}) : hideFilter = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershopProvider = ref.watch(getMyBarbershopProvider);

    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundChair),
          fit: BoxFit.cover,
          opacity: .4,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            barbershopProvider.maybeWhen(
              data: (barbershop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicWidth(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.grey,
                            child: Text('RE'),
                          ),
                          const SizedBox(width: 14),
                          Flexible(
                            child: Text(
                              barbershop.name,
                              style: AppTextStyles.textBold.copyWith(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            // style: TextButton.styleFrom(
                            //   padding: const EdgeInsets.symmetric(horizontal: 1),
                            // ),
                            child: const Text('Editar'),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(homeAdmVmProvider.notifier).logout();
                      },
                      icon: PhosphorIcon(PhosphorIcons.regular.signOut),
                    ),
                  ],
                );
              },
              orElse: () {
                return const Center(child: AppLoader());
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Bem-vindo',
              style: AppTextStyles.textMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Agende um Cliente',
              style: AppTextStyles.textSemiBold.copyWith(fontSize: 40),
            ),
            Offstage(offstage: hideFilter, child: const SizedBox(height: 10)),
            Offstage(
              offstage: hideFilter,
              child: TextFormField(
                onTapOutside: (event) => context.unfocus(),
                decoration: InputDecoration(
                  // labelText: 'Nome',
                  hintText: 'Buscar colaborador',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: PhosphorIcon(PhosphorIcons.regular.magnifyingGlass),
                  ),
                ),
                textCapitalization: TextCapitalization.words,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
