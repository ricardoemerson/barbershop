import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/config/config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/helpers/message_helper.dart';
import '../../../../core/widgets/hours_panel.dart';
import '../../../../core/widgets/week_days_panel.dart';
import 'barbershop_register_state.dart';
import 'barbershop_register_vm.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends ConsumerState<BarbershopRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVm = ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (previous, state) {
      switch (state.status) {
        case BarbershopRegisterStatus.initial:
          break;
        case BarbershopRegisterStatus.success:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
        case BarbershopRegisterStatus.error:
          MessageHelper.showError('Erro ao registrar a barbearia.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Estabelecimento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      controller: _nameEC,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Informe seu nome',
                      ),
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.required(AppValidatorMessages.required),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      controller: _emailEC,
                      decoration: const InputDecoration(
                        labelText: 'e-Mail',
                        hintText: 'Informe seu e-Mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.multiple([
                        Validatorless.required(AppValidatorMessages.required),
                        Validatorless.email(AppValidatorMessages.email)
                      ]),
                    ),
                    const SizedBox(height: 24),
                    WeekDaysPanel(
                      onPressed: (value) {
                        barbershopRegisterVm.addOrRemoveOpenDay(value);
                      },
                    ),
                    const SizedBox(height: 24),
                    HoursPanel(
                      onPressed: (value) {
                        barbershopRegisterVm.addOrRemoveOpenHour(value);
                      },
                      startTime: 6,
                      endTime: 23,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        final formIsValid = _formKey.currentState?.validate() ?? false;

                        if (formIsValid) {
                          barbershopRegisterVm.register(
                            name: _nameEC.trimmedText,
                            email: _emailEC.trimmedText,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      child: const Text('CADASTRAR ESTABELECIMENTO'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
