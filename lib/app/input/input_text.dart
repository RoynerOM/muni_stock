import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.label = '',
    this.width,
    this.placeholder = '',
    this.controller,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.style,
    this.sufixIcon,
    this.onTap,
    this.prefixIcon,
    this.obscureText = false,
  });
  final String label;
  final String placeholder;
  final double? width;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final TextStyle? style;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 4),
          TextField(
            readOnly: readOnly,
            enabled: enabled,
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            style: style,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: placeholder,
              suffixIcon: sufixIcon,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(color: Colors.lightGreen, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
