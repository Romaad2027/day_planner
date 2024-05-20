import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget child;

  const LoadingButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: isLoading ? const CircularProgressIndicator.adaptive() : child,
    );
  }
}
