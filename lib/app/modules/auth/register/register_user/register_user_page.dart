import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/config/config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/helpers/message_helper.dart';
import 'register_user_vm.dart';

class RegisterUserPage extends ConsumerStatefulWidget {
  const RegisterUserPage({super.key});

  @override
  ConsumerState<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends ConsumerState<RegisterUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerUserVm = ref.watch(registerUserVmProvider.notifier);

    ref.listen(registerUserVmProvider, (previous, state) {
      switch (state) {
        case RegisterUserStatus.initial:
          break;
        case RegisterUserStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case RegisterUserStatus.error:
          MessageHelper.showError('Erro ao registrar usuário administrador.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
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
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      controller: _passwordEC,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Informe sua senha',
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.multiple([
                        Validatorless.required(AppValidatorMessages.required),
                        Validatorless.min(6, AppValidatorMessages.min(6))
                      ]),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      decoration: const InputDecoration(
                        labelText: 'Confirmar senha',
                        hintText: 'Informe sua senha novamente',
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.multiple([
                        Validatorless.required(AppValidatorMessages.required),
                        Validatorless.compare(_passwordEC, AppValidatorMessages.compare),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        final formIsValid = _formKey.currentState?.validate() ?? false;

                        if (formIsValid) {
                          registerUserVm.register(
                            name: _nameEC.trimmedText,
                            email: _emailEC.trimmedText,
                            password: _passwordEC.trimmedText,
                          );
                        }
                      },
                      child: const Text('ACESSAR'),
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
