import 'package:flutter/material.dart';

class ButtonConstraintBox extends StatelessWidget {
  final Widget child;
  const ButtonConstraintBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: 230,
      ),
      child: child,
    ));
  }
}
