import 'package:flutter/material.dart';

import '../theme/theme.dart';

class HourButton extends StatelessWidget {
  final String label;

  const HourButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 4),
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
    );
  }
}
