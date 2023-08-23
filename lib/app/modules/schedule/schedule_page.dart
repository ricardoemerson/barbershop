import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/config/config.dart';
import '../../core/extensions/extensions.dart';
import '../../core/helpers/message_helper.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/hours_panel.dart';
import '../../core/widgets/schedule_calendar.dart';
import '../../core/widgets/user_avatar.dart';
import '../../data/models/user_model.dart';
import 'schedule_state.dart';
import 'schedule_vm.dart';

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
    final user = ModalRoute.of(context)?.settings.arguments as UserModel;

    final scheduleVm = ref.watch(scheduleVmProvider.notifier);

    final employeeData = switch (user) {
      UserAdmModel(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!
        ),
      UserEmployeeModel(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours
        ),
    };

    ref.listen(scheduleVmProvider.select((state) => state.status), (previous, status) {
      switch (status) {
        case ScheduleStatus.initial:
          break;
        case ScheduleStatus.success:
          MessageHelper.showSuccess('Cliente agendado com sucesso.', context);

          Navigator.of(context).pop();
        case ScheduleStatus.error:
          MessageHelper.showError('Erro ao agendar cliente.', context);
      }
    });

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
                    user.name,
                    style: AppTextStyles.textMedium.copyWith(
                      fontSize: 20,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
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
                              scheduleVm.selectDate(value);
                              displayCalendar = false;
                            });
                          },
                          workDays: employeeData.workDays,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    enabledTimes: employeeData.workHours,
                    onPressed: scheduleVm.selectHour,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final formIsValid = _formKey.currentState?.validate() ?? false;

                      if (formIsValid) {
                        final hourIsSelected = ref.watch(
                          scheduleVmProvider.select((state) => state.scheduleHour != null),
                        );

                        if (!hourIsSelected) {
                          MessageHelper.showError(
                            'Por favor, selecione um horário de atendimento.',
                            context,
                          );

                          return;
                        }

                        scheduleVm.register(user: user, clientName: _nameEC.trimmedText);
                      }
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
