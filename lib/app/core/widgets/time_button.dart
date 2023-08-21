import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final List<int>? enabledTimes;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    this.enabledTimes,
    required this.onPressed,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected ? AppColors.white : AppColors.grey;
    var backgroundColor = selected ? AppColors.primary : AppColors.background;
    final borderColor = selected ? AppColors.primary : AppColors.grey;

    final TimeButton(:label, :value, :enabledTimes, :onPressed) = widget;

    final disabledTime = enabledTimes != null && !enabledTimes.contains(value);

    if (disabledTime) {
      backgroundColor = AppColors.greyDark;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: disabledTime
            ? null
            : () {
                onPressed(value);

                setState(() {
                  selected = !selected;
                });
              },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 64,
          height: 36,
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
