import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'hour_button.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
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
              HourButton(label: '${i.toString().padLeft(2, '0')}:00'),
          ],
        ),
      ],
    );
  }
}
