import 'package:flutter/material.dart';

class MuniIconButton extends StatelessWidget {
  const MuniIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor = Colors.black87,
    this.tooltip = '',
  });
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final String tooltip;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
