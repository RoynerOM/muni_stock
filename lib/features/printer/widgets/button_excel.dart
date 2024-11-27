import 'package:flutter/material.dart';
import 'package:muni_stock/app/color/hex_color.dart';

class ButtonExcel extends StatelessWidget {
  const ButtonExcel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: HexColor('#1B2162'),
          ),
        ),
        child: const Text('Exportar a Excel'),
      ),
    );
  }
}
