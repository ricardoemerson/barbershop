import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../theme/theme.dart';
import 'week_day_button.dart';

class WeekDaysPanel extends StatelessWidget {
  const WeekDaysPanel({super.key});

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
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeekDayButton(label: 'Seg'),
                WeekDayButton(label: 'Ter'),
                WeekDayButton(label: 'Qua'),
                WeekDayButton(label: 'Qui'),
                WeekDayButton(label: 'Sex'),
                WeekDayButton(label: 'Sáb'),
                WeekDayButton(label: 'Dom'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
