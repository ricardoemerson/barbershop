import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/config/config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/hours_panel.dart';
import '../../../../core/widgets/week_days_panel.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
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
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'e-Mail',
                        hintText: 'Informe seu e-Mail',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.multiple([
                        Validatorless.required(AppValidatorMessages.required),
                        Validatorless.email(AppValidatorMessages.email)
                      ]),
                    ),
                    const SizedBox(height: 24),
                    WeekDaysPanel(
                      onPressed: (value) {
                        log('Dia selecionado $value');
                      },
                    ),
                    const SizedBox(height: 24),
                    HoursPanel(
                      onPressed: (value) {
                        log('Dia selecionado $value');
                      },
                      startTime: 6,
                      endTime: 23,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        final formIsValid = _formKey.currentState?.validate() ?? false;

                        if (formIsValid) {}
                      },
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
