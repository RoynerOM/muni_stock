import 'package:flutter/material.dart';
import 'package:muni_stock/app/color/hex_color.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onTap,
  });
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor('#1B2162'),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
