import 'package:flutter/material.dart';

class ShowPasswordButton extends StatelessWidget {
  final bool showPassword;
  final ValueChanged<bool> toggle;

  const ShowPasswordButton({
    super.key,
    required this.showPassword,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        toggle(!showPassword);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: showPassword
            ? const Icon(
                Icons.visibility_off_outlined,
                key: ValueKey('icon-a'),
              )
            : const Icon(
                Icons.visibility_outlined,
                key: ValueKey('icon-b'),
              ),
      ),
    );
  }
}
