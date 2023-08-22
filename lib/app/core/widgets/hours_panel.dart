import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'time_button.dart';

class HoursPanel extends StatefulWidget {
  final int startTime;
  final int endTime;
  final List<int>? enabledTimes;
  final ValueChanged<int> onPressed;
  final bool singleSelection;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    this.enabledTimes,
    required this.onPressed,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    this.enabledTimes,
    required this.onPressed,
  }) : singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelectedValue;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(:enabledTimes, :startTime, :endTime, :singleSelection, :onPressed) = widget;

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
                onPressed: (value) {
                  setState(() {
                    if (singleSelection) {
                      if (lastSelectedValue == value) {
                        lastSelectedValue = null;
                      } else {
                        lastSelectedValue = value;
                      }
                    }
                  });

                  onPressed(value);
                },
                label: '${i.toString().padLeft(2, '0')}:00',
                value: i,
                enabledTimes: enabledTimes,
                singleSelection: singleSelection,
                selectedTime: lastSelectedValue,
              ),
          ],
        ),
      ],
    );
  }
}
