import 'package:flutter/material.dart';

import '../theme/theme.dart';

class WeekDayButton extends StatelessWidget {
  final String label;

  const WeekDayButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.textRegular.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
