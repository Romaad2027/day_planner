import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  final Widget child;
  const DataContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: child,
    );
  }
}
