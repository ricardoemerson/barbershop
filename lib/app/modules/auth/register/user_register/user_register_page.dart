import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/config/config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/helpers/message_helper.dart';
import '../../../../core/widgets/show_password_button.dart';
import 'user_register_vm.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends ConsumerState<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  var showPassword = false;
  var showConfirmationPassword = false;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (previous, state) {
      switch (state) {
        case UserRegisterStatus.initial:
          break;
        case UserRegisterStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStatus.error:
          MessageHelper.showError('Erro ao registrar usuário administrador.', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
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
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      controller: _passwordEC,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Informe sua senha',
                        suffixIcon: ShowPasswordButton(
                          showPassword: showPassword,
                          toggle: (value) {
                            setState(() {
                              showPassword = value;
                            });
                          },
                        ),
                      ),
                      obscureText: !showPassword,
                      textInputAction: TextInputAction.next,
                      validator: Validatorless.multiple([
                        Validatorless.required(AppValidatorMessages.required),
                        Validatorless.min(6, AppValidatorMessages.min(6))
                      ]),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      onTapOutside: (event) => context.unfocus(),
                      decoration: InputDecoration(
                        labelText: 'Confirmar senha',
                        hintText: 'Informe sua senha novamente',
                        suffixIcon: ShowPasswordButton(
                          showPassword: showConfirmationPassword,
                          toggle: (value) {
                            setState(() {
                              showConfirmationPassword = value;
                            });
                          },
                        ),
                      ),
                      obscureText: !showConfirmationPassword,
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
                          userRegisterVm.register(
                            name: _nameEC.trimmedText,
                            email: _emailEC.trimmedText,
                            password: _passwordEC.trimmedText,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      child: const Text('CRIAR CONTA'),
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
