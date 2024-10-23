import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muni_stock/app/buttons/icon_button.dart';
import 'package:muni_stock/app/device/device.dart';
import 'package:muni_stock/app/dialogs/delete_alert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ConsumableTable extends StatefulWidget {
  const ConsumableTable({super.key});

  @override
  State<ConsumableTable> createState() => _ConsumableTableState();
}

class _ConsumableTableState extends State<ConsumableTable> {
  late UserDataSource _userDataSource;
  final int _rowsPerPage = 15;
  int _currentPageIndex = 0;
  final double _rowHeight = 80;

  // Sample data
  final List<Consumable> _allConsumables = List.generate(
    20,
    (index) => Consumable(
      id: index,
      date: '14/10/2024',
      name: 'Impresora $index',
      destination: 'x2655s',
      status: 'In Stock',
      stock: '10',
    ),
  );

  @override
  void initState() {
    super.initState();
    _userDataSource = UserDataSource(users: _getPaginatedConsumables());
  }

  List<Consumable> _getPaginatedConsumables() {
    final startIndex = _currentPageIndex * _rowsPerPage;
    final endIndex =
        (startIndex + _rowsPerPage).clamp(0, _allConsumables.length);
    return _allConsumables.sublist(startIndex, endIndex);
  }

  void _onNextPage() {
    if ((_currentPageIndex + 1) * _rowsPerPage < _allConsumables.length) {
      setState(() {
        _currentPageIndex++;
        _userDataSource.updateRows(_getPaginatedConsumables());
      });
    }
  }

  void _onPreviousPage() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
        _userDataSource.updateRows(_getPaginatedConsumables());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1320, maxHeight: 1400),
      child: SfDataGrid(
        verticalScrollPhysics: const NeverScrollableScrollPhysics(),
        // horizontalScrollPhysics: NeverScrollableScrollPhysics(),
        footer: _buildPaginationFooter(),
        rowHeight: _rowHeight,
        source: _userDataSource,
        columns: _buildGridColumns(),
        allowColumnsResizing: true,
        columnResizeMode: ColumnResizeMode.onResize,
        columnWidthMode: ColumnWidthMode.fill,
        onColumnResizeEnd: (value) {
          print("Column resized: $value");
        },
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Container(
      height: 56,
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onPreviousPage,
            tooltip: 'Previous Page',
          ),
          Text('Page ${_currentPageIndex + 1}'),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _onNextPage,
            tooltip: 'Next Page',
          ),
        ],
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    return [
      GridColumn(
        columnName: 'id',
        label: _buildHeaderCell('Nombre'),
      ),
      GridColumn(
        width: 150,
        columnName: 'fecha',
        label: _buildHeaderCell('Fecha'),
      ),
      GridColumn(
        columnName: 'ubicacion',
        label: _buildHeaderCell('Ubicación'),
      ),
      GridColumn(
        width: 150,
        columnName: 'stock',
        label: _buildHeaderCell('Cantidad'),
      ),
      GridColumn(
        width: 150,
        columnName: 'estado',
        label: _buildHeaderCell('Estado'),
      ),
      GridColumn(
        width: 200,
        columnName: 'acciones',
        label: _buildHeaderCell('Acciones'),
      ),
    ];
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}

class UserDataSource extends DataGridSource {
  List<Consumable> users;

  UserDataSource({required this.users}) {
    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows = users.map<DataGridRow>((user) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'id', value: user.name),
        DataGridCell<String>(columnName: 'fecha', value: user.date),
        DataGridCell<String>(columnName: 'ubicacion', value: user.destination),
        DataGridCell<String>(columnName: 'stock', value: user.stock),
        DataGridCell<String>(columnName: 'estado', value: user.status),
        DataGridCell<Widget>(
          columnName: 'acciones',
          value: _buildActionButtons(user),
        ),
      ]);
    }).toList();
  }

  Widget _buildActionButtons(Consumable user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MuniIconButton(
          tooltip: 'Entrada',
          icon: CupertinoIcons.add_circled,
          onPressed: () {},
        ),
        MuniIconButton(
          tooltip: 'Salida',
          icon: CupertinoIcons.minus_circle,
          onPressed: () {},
        ),
        MuniIconButton(
          tooltip: 'Editar',
          icon: CupertinoIcons.pencil_circle,
          onPressed: () {},
        ),
        MuniIconButton(
          tooltip: 'Eliminar',
          iconColor: Colors.red,
          icon: CupertinoIcons.trash_circle,
          onPressed: () {
            // showDeleteDialog(context, () {});
          },
        ),
      ],
    );
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child:
              (cell.value is Widget) ? cell.value : Text(cell.value.toString()),
        );
      }).toList(),
    );
  }

  void updateRows(List<Consumable> newConsumables) {
    users = newConsumables;
    _buildDataGridRows();
    notifyListeners();
  }
}

class Consumable {
  final int id;
  final String name;
  final String date;
  final String destination;
  final String stock;
  final String status;

  Consumable({
    required this.id,
    required this.name,
    required this.date,
    required this.destination,
    required this.stock,
    required this.status,
  });
}
