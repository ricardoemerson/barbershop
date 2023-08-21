import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../theme/theme.dart';
import 'week_day_button.dart';

class WeekDaysPanel extends StatelessWidget {
  final List<String>? enabledDays;
  final ValueChanged<String> onPressed;

  const WeekDaysPanel({
    super.key,
    this.enabledDays,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecione os dias da semana',
            style: AppTextStyles.textSectionTitle,
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Seg',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Ter',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Qua',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Qui',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Sex',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Sáb',
                  enabledDays: enabledDays,
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Dom',
                  enabledDays: enabledDays,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
