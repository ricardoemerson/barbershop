import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/config.dart';
import '../../core/helpers/message_helper.dart';
import 'splash_vm.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  var _animationEnded = false;
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 1.0;
      });
    });
  }

  double get _logoAnimationWidth => 150 * _scale;
  double get _logoAnimationHeight => 170 * _scale;

  void _redirect(String routeName) {
    if (!_animationEnded) {
      _redirectTimer?.cancel();

      _redirectTimer = Timer(const Duration(milliseconds: 300), () {
        _redirect(routeName);
      });
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      splashVmProvider,
      (previous, state) {
        state.whenOrNull(
          error: (error, stackTrace) {
            MessageHelper.showError(
              'Erro ao verificar se o usuário já estava autenticado.',
              context,
            );

            _redirect('/auth/login');
          },
          data: (data) {
            switch (data) {
              case SplashStatus.loggedAdm:
                _redirect('/home/adm');
              case SplashStatus.loggedEmployee:
                _redirect('/home/employee');
              case _:
                _redirect('/auth/login');
            }
          },
        );
      },
    );

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
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 3),
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            onEnd: () {
              setState(() {
                _animationEnded = true;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 3),
              curve: Curves.linearToEaseOut,
              width: _logoAnimationWidth,
              height: _logoAnimationHeight,
              child: Image.asset(
                AppImages.imageLogo,
                fit: BoxFit.cover,
                width: 500,
                height: 500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
