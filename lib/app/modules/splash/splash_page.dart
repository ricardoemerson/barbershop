import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/config/config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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

              // _redirect('/auth/login');
              _redirect('/auth/register/barbershop');
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
