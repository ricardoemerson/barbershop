import 'package:flutter/material.dart';

import '../theme/theme.dart';

class WeekDayButton extends StatefulWidget {
  final String label;
  final ValueChanged<String> onPressed;

  const WeekDayButton({
    super.key,
    required this.label,
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
    final backgroundColor = selected ? AppColors.primary : AppColors.background;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          widget.onPressed(widget.label);

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
            border: Border.all(color: selected ? AppColors.primary : AppColors.grey),
          ),
          child: Center(
            child: Text(
              widget.label,
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
