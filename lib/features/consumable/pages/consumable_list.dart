import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/spinner/dual_ring.dart';
import 'package:muni_stock/features/consumable/bloc/consumable_bloc.dart';
import 'package:muni_stock/features/consumable/widgets/consumible_item.dart';

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
                maxCrossAxisExtent: 480,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                mainAxisExtent: 403),
            itemBuilder: (context, index) {
              final item = state.filterConsumables[index];
              return ProductCard(
                  id: (index + 1).toString(),
                  status: '',
                  nombre: item.modelo,
                  tipo: item.tipo,
                  fecha: "",
                  stock: item.stock,
                  tintas: item.tintas);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: HexColor('3C3E3D'),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
