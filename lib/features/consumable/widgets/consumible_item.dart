import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/core/utils/formats.dart';
import 'package:muni_stock/features/consumable/models/impresora_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.status,
    required this.nombre,
    required this.tipo,
    required this.fecha,
    required this.stock,
    required this.tintas, // Añadido parámetro para las tintas
  });

  final String id;
  final String status;
  final String nombre;
  final String tipo;
  final String fecha;
  final String stock;
  final Tintas tintas; // Lista de tintas con nombres y cantidades

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _encabezado(),
            const SizedBox(height: 5),
            /*  _detalles(),*/
            const SizedBox(height: 20),
            _tintas(),
            const SizedBox(height: 10),
            const Divider(height: 20),
            _acciones(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _encabezado() {
    return ListTile(
      title: Text(
        nombre,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: HexColor('101010'),
        ),
      ),
      subtitle: Text(
        tipo,
        style: TextStyle(
          fontSize: 16,
          color: HexColor('767676'),
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        decoration: BoxDecoration(
            color: HexColor('F9CC49'), borderRadius: BorderRadius.circular(12)),
        child: Text(
          id,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _detalles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailColumn(label: 'Fecha:', value: getFormattedDate(fecha)),
          _buildDetailColumn(label: 'Stock:', value: stock),
        ],
      ),
    );
  }

  Widget _buildDetailColumn({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  Widget _acciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildIconButton(
            icon: CupertinoIcons.minus,
            tooltip: 'Salida',
            color: HexColor('3E403F'),
            onPressed: () {}),
        _buildIconButton(
            icon: Icons.add,
            tooltip: 'Entrada',
            color: HexColor('3E403F'),
            onPressed: () {}),
        _buildIconButton(
            icon: Icons.edit,
            tooltip: 'Editar',
            color: HexColor('3E403F'),
            onPressed: () {}),
        _buildIconButton(
            icon: Icons.delete,
            tooltip: 'Eliminar',
            color: Colors.red,
            onPressed: () {}),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      tooltip: tooltip,
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    );
  }

  // Nueva función que muestra la lista de tintas
  Widget _tintas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tintas:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: HexColor('101010'),
          ),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap:
              true, // Evita que el ListView ocupe más espacio del necesario
          physics:
              NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Negro", style: TextStyle(fontSize: 16)),
                  Text('${tintas.negro} unidades',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Amarillo", style: TextStyle(fontSize: 16)),
                  Text('${tintas.amarillo} unidades',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Magenta", style: TextStyle(fontSize: 16)),
                  Text('${tintas.magenta} unidades',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Cyan", style: TextStyle(fontSize: 16)),
                  Text('${tintas.cyan} unidades',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
