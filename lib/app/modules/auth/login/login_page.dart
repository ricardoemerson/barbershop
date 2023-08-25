import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/config/config.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/helpers/message_helper.dart';
import '../../../core/theme/theme.dart';
import 'login_state.dart';
import 'login_vm.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (previous, state) {
      switch (state.status) {
        case LoginStatus.initial:
          break;
        case LoginStatus.error:
          MessageHelper.showError(state.errorMessage ?? 'Erro ao realizar login.', context);
          break;
        case LoginStatus.employeeLogin:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/employee', (route) => false);
          break;
        case LoginStatus.admLogin:
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false);
          break;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundChair),
            fit: BoxFit.cover,
            opacity: .4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.imageLogo),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (event) => context.unfocus(),
                            controller: _emailEC,
                            autofocus: true,
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
                          ElevatedButton(
                            onPressed: () {
                              final formIsValid = _formKey.currentState?.validate() ?? false;

                              if (formIsValid) {
                                login(_emailEC.trimmedText, _passwordEC.trimmedText);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            child: const Text('ACESSAR'),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.white,
                            ),
                            child: const Text('Esqueci minha senha'),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pushNamed('/auth/register/user'),
                        child: const Text('Criar conta'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
