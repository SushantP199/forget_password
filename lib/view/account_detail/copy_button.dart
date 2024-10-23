import 'package:flutter/material.dart';

class CopyButton extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final double size;

  const CopyButton({
    required this.onTap,
    required this.color,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.copy_rounded,
        color: color,
        size: size,
      ),
    );
  }
}
