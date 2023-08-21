import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../config/config.dart';

class UserAvatar extends StatelessWidget {
  final String? url;

  const UserAvatar({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Image(
            image: switch (url) {
              final avatar? => NetworkImage(avatar),
              _ => const AssetImage(AppImages.avatar),
            } as ImageProvider,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: -8,
            right: -8,
            child: IconButton(
              onPressed: () {},
              icon: PhosphorIcon(
                PhosphorIcons.regular.plusCircle,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
