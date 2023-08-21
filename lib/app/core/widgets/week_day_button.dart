import 'package:flutter/material.dart';

import '../theme/theme.dart';

class WeekDayButton extends StatefulWidget {
  final String label;
  final List<String>? enabledDays;
  final ValueChanged<String> onPressed;

  const WeekDayButton({
    super.key,
    required this.label,
    this.enabledDays,
    required this.onPressed,
  });

  @override
  State<WeekDayButton> createState() => _WeekDayButtonState();
}

class _WeekDayButtonState extends State<WeekDayButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected ? AppColors.white : AppColors.grey;
    var backgroundColor = selected ? AppColors.primary : AppColors.background;
    final borderColor = selected ? AppColors.primary : AppColors.grey;

    final WeekDayButton(:label, :enabledDays, :onPressed) = widget;

    final disabledDay = enabledDays != null && !enabledDays.contains(label);

    if (disabledDay) {
      backgroundColor = AppColors.greyDark;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: disabledDay
            ? null
            : () {
                onPressed(label);

                setState(() {
                  selected = !selected;
                });
              },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.textRegular.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
