import 'package:flutter/material.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/device/device.dart';
import 'package:muni_stock/app/input/input_date.dart';
import 'package:muni_stock/app/input/input_select.dart';
import 'package:muni_stock/app/input/input_text.dart';
import 'package:muni_stock/features/consumable/widgets/button_excel.dart';
import 'package:muni_stock/features/consumable/widgets/table.dart';

class ConsumableIndex extends StatelessWidget {
  const ConsumableIndex({super.key});

  @override
  Widget build(BuildContext context) {
    Device.getInfo(context);
    return Scaffold(
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: HexColor('#1B2162'),
        width: 100,
        child: const Column(
          children: [
            SizedBox(height: 40),
            Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Icon(
              Icons.bar_chart,
              size: 32,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Spacer(),
            Icon(
              Icons.exit_to_app,
              size: 32,
              color: Colors.white,
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Inventario',
          style: TextStyle(
            fontSize: 20,
            color: HexColor('#1B2162'),
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [ButtonExcel()],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Divider(color: HexColor('#1B2162')),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                constraints: const BoxConstraints(maxWidth: 1320),
                child: SizedBox(
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 24,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Device.span(context, lg: 12, xl: 6, xxl: 5),
                        child: InputText(
                          placeholder: 'Buscar',
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: [
                            SizedBox(
                              width: Device.span(
                                context,
                                md: 4,
                                lg: 4,
                                xl: 2,
                                xxl: 2,
                              ),
                              child: InputDate(
                                hitText: 'Fecha',
                                onChanged: (value) {},
                                controller: TextEditingController(),
                              ),
                            ),
                            SizedBox(
                              width: Device.span(
                                context,
                                xs: 6,
                                sm: 6,
                                md: 4,
                                lg: 4,
                                xl: 2,
                                xxl: 2,
                              ),
                              child: InputSelect(
                                hintText: 'Estado',
                                onChanged: (value) {},
                                controller: TextEditingController(),
                                options: [
                                  Option(value: 'En Stock'),
                                  Option(value: 'Bajo Stock'),
                                  Option(value: 'Agotado'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Device.span(
                                context,
                                xs: 6,
                                sm: 6,
                                md: 4,
                                lg: 4,
                                xl: 2,
                                xxl: 2,
                              ),
                              child: InputSelect(
                                hintText: 'Categoria',
                                onChanged: (value) {},
                                controller: TextEditingController(),
                                options: [
                                  Option(value: 'Tóner'),
                                  Option(value: 'Inyeccion'),
                                  Option(value: 'Cartucho'),
                                  Option(value: 'Térmico'),
                                  Option(value: 'Otros'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const ConsumableTable(),
            ],
          ),
        ),
      ),
    );
  }
}
