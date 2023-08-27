import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/user_model.dart';

class HomeEmployeeTile extends StatelessWidget {
  final UserModel employee;

  const HomeEmployeeTile({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          switch (employee.avatar) {
            final avatar? => Image(
                image: NetworkImage(avatar),
              ),
            _ => AdvancedAvatar(
                size: 56,
                decoration: BoxDecoration(
                  color: AppColors.greyDark,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                name: employee.name,
              )
          },
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: AppTextStyles.textMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/schedule', arguments: employee);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        textStyle: AppTextStyles.textSemiBold.copyWith(fontSize: 12),
                      ),
                      child: const Text('AGENDAR'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/employee/schedule', arguments: employee);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        textStyle: AppTextStyles.textSemiBold.copyWith(fontSize: 12),
                      ),
                      child: const Text('VER AGENDA'),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: PhosphorIcon(
                          PhosphorIcons.regular.pencilSimple,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: PhosphorIcon(
                          PhosphorIcons.regular.trash,
                          color: AppColors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
