import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton(
              onPressed: () {
                // Acción para exportar a Excel
              },
              child: Text('Export to Excel'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 40),
            Icon(Icons.home, size: 32),
            SizedBox(height: 20),
            Icon(Icons.bar_chart, size: 32),
            SizedBox(height: 20),
            Icon(Icons.print, size: 32),
            SizedBox(height: 20),
            Icon(Icons.settings, size: 32),
            Spacer(),
            Icon(Icons.person, size: 32),
            SizedBox(height: 40),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de búsqueda y filtros
            Row(
              children: [
                // Campo de búsqueda
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Filtro de fecha
                DropdownButton<String>(
                  hint: Text('Date'),
                  items: <String>['Today', 'This week', 'This month']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Acción para cambiar filtro de fecha
                  },
                ),
                SizedBox(width: 16),
                // Filtro de estatus
                DropdownButton<String>(
                  hint: Text('Estatus'),
                  items: <String>['En Stock', 'Agotado'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Acción para cambiar filtro de estatus
                  },
                ),
                SizedBox(width: 16),
                // Filtro de categorías
                DropdownButton<String>(
                  hint: Text('Categorias'),
                  items: <String>['Electronics', 'Books', 'Clothing']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Acción para cambiar filtro de categorías
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Tabla de inventario
            Expanded(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Orden ID')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Destination')),
                  DataColumn(label: Text('Items')),
                  DataColumn(label: Text('Estatus')),
                  DataColumn(label: Text('Operation')),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('001')),
                      DataCell(Text('01/01/2024')),
                      DataCell(Text('Departamento TI')),
                      DataCell(Text('5')),
                      DataCell(Chip(
                        label: Text('En Stock'),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.white),
                      )),
                      DataCell(Row(
                        children: [
                          Icon(Icons.add_circle_outline),
                          SizedBox(width: 8),
                          Icon(Icons.remove_circle_outline),
                          SizedBox(width: 8),
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Icon(Icons.delete, color: Colors.red),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar nueva orden
        },
        child: Text('+New Orden'),
        backgroundColor: Colors.blue[900],
      ),
    );
  }
}
