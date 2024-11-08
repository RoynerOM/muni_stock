import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/spinner/dual_ring.dart';
import 'package:muni_stock/features/consumable/bloc/consumable_bloc.dart';

class ConsumableList extends StatefulWidget {
  const ConsumableList({super.key});

  @override
  State<ConsumableList> createState() => _ConsumableListState();
}

class _ConsumableListState extends State<ConsumableList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista de Consumibles'),
      ),
      body: BlocConsumer<ConsumableBloc, ConsumableState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.react == React.getLoading) {
            return const Center(child: DualRing());
          }

          return GridView.builder(
            padding: const EdgeInsets.all(50.0),
            itemCount: state.filterConsumables.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 360,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              mainAxisExtent: 264,
            ),
            itemBuilder: (context, index) {
              final item = state.filterConsumables[index];
              return ProductCard(
                id: item.id,
                status: '',
                nombre: item.nombre,
                tipo: item.tipo,
                fecha: item.fecha,
                stock: item.items,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('New orden'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 2, 0, 117),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.status,
    required this.nombre,
    required this.tipo,
    required this.fecha,
    required this.stock,
  });
  final String id;
  final String status;
  final String nombre;
  final String tipo;
  final String fecha;
  final String stock;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  status,
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              nombre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              tipo,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Fecha:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(fecha),
                    const SizedBox(height: 5),
                    const Text(
                      'ITEMS:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(stock),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  tooltip: 'Salida',
                  icon: const Icon(CupertinoIcons.minus, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Entrada',
                  icon: const Icon(Icons.add, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Editar',
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Eliminar',
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
