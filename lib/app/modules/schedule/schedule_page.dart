import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/config/config.dart';
import '../../core/extensions/extensions.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/hours_panel.dart';
import '../../core/widgets/schedule_calendar.dart';
import '../../core/widgets/user_avatar.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _dateEC = TextEditingController();

  final dateFormat = DateFormat('dd/MM/yyyy');
  var displayCalendar = false;

  @override
  void dispose() {
    _nameEC.dispose();
    _dateEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cliente'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const UserAvatar(),
                  const SizedBox(height: 25),
                  Text(
                    'Nome e Sobrenome',
                    style: AppTextStyles.textMedium.copyWith(
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        TextFormField(
                          onTapOutside: (event) => context.unfocus(),
                          controller: _nameEC,
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'Cliente',
                            hintText: 'Informe o nome do cliente',
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          onTap: () {
                            setState(() {
                              displayCalendar = true;
                            });
                          },
                          onTapOutside: (event) => context.unfocus(),
                          readOnly: true,
                          controller: _dateEC,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Data',
                            hintText: 'Selecione uma data',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: PhosphorIcon(
                                PhosphorIcons.regular.calendarPlus,
                                size: 28,
                              ),
                            ),
                          ),
                          validator: Validatorless.required(AppValidatorMessages.required),
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: !displayCalendar,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ScheduleCalendar(
                          onCancel: () {
                            setState(() {
                              displayCalendar = false;
                            });
                          },
                          onSelectDate: (value) {
                            setState(() {
                              _dateEC.text = dateFormat.format(value);
                              displayCalendar = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  HoursPanel(
                    startTime: 6,
                    endTime: 23,
                    enabledTimes: const [6, 7, 8],
                    onPressed: (value) {},
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final formIsValid = _formKey.currentState?.validate() ?? false;

                      if (formIsValid) {}
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('AGENDAR CLIENTE'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
