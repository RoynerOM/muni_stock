import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/dialogs/banner_ui.dart';
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
        listener: (context, state) {
          if (state.react == React.deleteSuccess) {
            showAlertSuccess('Ok', 'Elemento eliminado!');
          }

          if (state.react == React.postError) {
            showAlertError('Error', 'No se pudo eliminar');
          }
        },
        builder: (context, state) {
          if (state.react == React.getLoading) {
            return const Center(child: DualRing());
          }

          if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminando impresora',
              ),
            );
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
                serie: item.serie,
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

  void showAlertError(String title, String message) {
    Alert.error(context, title: title, message: message);
  }

  void showAlertSuccess(String title, String message) {
    Alert.success(context, title: title, message: message, pop: false);
  }
}
