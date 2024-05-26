import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;

  const CommonAppBar({
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
