import 'package:flutter/material.dart';
import 'package:muni_stock/app/device/device.dart';

class CenterScroll extends StatelessWidget {
  const CenterScroll({super.key, required this.child, this.constraints});
  final Widget child;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: Device.media(context),
            constraints: constraints ?? const BoxConstraints(maxWidth: 1320),
            child: child,
          ),
        ),
      ),
    );
  }
}
