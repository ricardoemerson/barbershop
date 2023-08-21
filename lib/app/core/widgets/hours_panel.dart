import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'time_button.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final List<int>? enabledTimes;
  final ValueChanged<int> onPressed;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    this.enabledTimes,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione os horários de atendimento',
          style: AppTextStyles.textSectionTitle,
        ),
        const SizedBox(height: 16),
        Wrap(
          runSpacing: 8,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                onPressed: onPressed,
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                enabledTimes: enabledTimes,
              ),
          ],
        ),
      ],
    );
  }
}
