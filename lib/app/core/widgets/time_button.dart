import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
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
    final backgroundColor = selected ? AppColors.primary : AppColors.background;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          widget.onPressed(widget.value);

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
