import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../theme/theme.dart';
import 'week_day_button.dart';

class WeekDaysPanel extends StatelessWidget {
  final ValueChanged<String> onPressed;

  const WeekDaysPanel({super.key, required this.onPressed});

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
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Ter',
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Qua',
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Qui',
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Sex',
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Sáb',
                ),
                WeekDayButton(
                  onPressed: onPressed,
                  label: 'Dom',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
