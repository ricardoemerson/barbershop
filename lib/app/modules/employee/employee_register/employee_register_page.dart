import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/config/app_validator_messages.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/helpers/message_helper.dart';
import '../../../core/providers/application_providers.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/hours_panel.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/week_days_panel.dart';
import '../../../data/models/barbershop_model.dart';
import 'employee_register_state.dart';
import 'employee_register_vm.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  var isAdmRegister = false;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status), (previous, status) {
      switch (status) {
        case EmployeeRegisterStatus.initial:
          break;
        case EmployeeRegisterStatus.success:
          MessageHelper.showSuccess('Colaborador cadastrado com sucesso.', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStatus.error:
          MessageHelper.showError('Erro ao registrar colaborador.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
        centerTitle: true,
      ),
      body: barbershopAsyncValue.when(
        data: (barbershop) {
          final BarbershopModel(:openingDays, :openingHours) = barbershop;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const UserAvatar(),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: isAdmRegister,
                            onChanged: (value) {
                              setState(() {
                                isAdmRegister = !isAdmRegister;
                                employeeRegisterVm.setAdmRegister(isAdmRegister);
                              });
                            },
                          ),
                          Flexible(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: AppTextStyles.textRegular.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Offstage(
                          offstage: isAdmRegister,
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              TextFormField(
                                onTapOutside: (event) => context.unfocus(),
                                controller: _nameEC,
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                  hintText: 'Informe o nome do colaborador',
                                ),
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                validator: isAdmRegister
                                    ? null
                                    : Validatorless.required(AppValidatorMessages.required),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                onTapOutside: (event) => context.unfocus(),
                                controller: _emailEC,
                                decoration: const InputDecoration(
                                  labelText: 'e-Mail',
                                  hintText: 'Informe o e-Mail do colaborador',
                                ),
                                textInputAction: TextInputAction.next,
                                validator: isAdmRegister
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(AppValidatorMessages.required),
                                        Validatorless.email(AppValidatorMessages.email)
                                      ]),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                onTapOutside: (event) => context.unfocus(),
                                controller: _passwordEC,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  hintText: 'Informe a senha do colaborador',
                                ),
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                validator: isAdmRegister
                                    ? null
                                    : Validatorless.multiple([
                                        Validatorless.required(AppValidatorMessages.required),
                                        Validatorless.min(6, AppValidatorMessages.min(6))
                                      ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      WeekDaysPanel(
                        onPressed: employeeRegisterVm.addOrRemoveOpenDays,
                        enabledDays: openingDays,
                      ),
                      const SizedBox(height: 24),
                      HoursPanel(
                        startTime: 6,
                        endTime: 23,
                        enabledTimes: openingHours,
                        onPressed: employeeRegisterVm.addOrRemoveOpenHours,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          final formIsValid = _formKey.currentState?.validate() ?? false;

                          if (formIsValid) {
                            final EmployeeRegisterState(
                              workDays: List(isEmpty: workDaysIsEmpty),
                              workHours: List(isEmpty: workHoursIsEmpty),
                            ) = ref.watch(employeeRegisterVmProvider);

                            if (workDaysIsEmpty || workHoursIsEmpty) {
                              MessageHelper.showError(
                                'Por favor, seleciona os dias da semana e o horário de atendimento.',
                                context,
                              );

                              return;
                            }

                            employeeRegisterVm.register(
                              name: _nameEC.trimmedText,
                              email: _emailEC.trimmedText,
                              password: _passwordEC.trimmedText,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('CADASTRAR COLABORADOR'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar a página', error: error, stackTrace: stackTrace);

          return const Center(
            child: Text('Erro ao carregar a página.'),
          );
        },
        loading: () => const AppLoader(),
      ),
    );
  }
}
