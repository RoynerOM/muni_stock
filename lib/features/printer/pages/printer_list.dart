import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/spinner/dual_ring.dart';
import 'package:muni_stock/features/printer/bloc/printer_bloc.dart';
import 'package:muni_stock/features/printer/pages/add_printer.dart';
import 'package:muni_stock/features/printer/widgets/consumible_item.dart';

class PrinterIndex extends StatefulWidget {
  const PrinterIndex({super.key});

  @override
  State<PrinterIndex> createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impresoras'),
      ),
      body: BlocConsumer<PrinterBloc, PrinterState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.react == React.getLoading) {
            return const Center(child: DualRing());
          }

          return GridView.builder(
            padding: const EdgeInsets.all(50.0),
            itemCount: state.filterPrinters.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 480,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                mainAxisExtent: 403),
            itemBuilder: (context, index) {
              final item = state.filterPrinters[index];
              return ProductCard(
                id: (index + 1).toString(),
                status: '',
                nombre: item.modelo,
                tipo: item.tipo,
                fecha: "",
                stock: item.stock,
                tintas: item.tintas,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPrinter()));
        },
        backgroundColor: HexColor('3C3E3D'),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
