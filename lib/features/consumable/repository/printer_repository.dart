import 'dart:convert';
import 'package:http/http.dart' as http;

class PrinterRepository {
  final String baseUrl;

  PrinterRepository({required this.baseUrl});

  // Obtener todas las impresoras
  Future<List<dynamic>> getPrinters() async {
    final response = await http.get(Uri.parse('$baseUrl/api/impresoras'));

    if (response.statusCode == 200) {
      return json.decode(response.body)[
          'printers']; // Suponiendo que la respuesta tiene un campo 'printers'
    } else {
      throw Exception('Error al cargar impresoras');
    }
  }

  // Obtener una impresora por ID
  Future<Map<String, dynamic>> getPrinterById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/impresoras/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener la impresora');
    }
  }

  // Agregar una nueva impresora
  Future<void> addPrinter(String name, String type) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/impresoras'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'type': type,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar impresora');
    }
  }

  // Actualizar una impresora
  Future<void> updatePrinter(int id, String name, String type) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/impresoras/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'type': type,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar impresora');
    }
  }

  // Eliminar una impresora
  Future<void> deletePrinter(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/impresoras/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar impresora');
    }
  }
}
