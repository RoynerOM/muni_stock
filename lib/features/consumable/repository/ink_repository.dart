import 'dart:convert';
import 'package:http/http.dart' as http;

class InkRepository {
  final String baseUrl;

  InkRepository({required this.baseUrl});

  // Obtener todas las tintas de una impresora
  Future<List<dynamic>> getInksByPrinterId(int printerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/tintas/$printerId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)[
          'inks']; // Suponiendo que la respuesta tiene un campo 'inks'
    } else {
      throw Exception('Error al cargar las tintas');
    }
  }

  // Agregar tinta a una impresora
  Future<void> addInk(int printerId, String type, int quantity, String model,
      String detail) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/tintas'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'printer_id': printerId,
        'type': type,
        'quantity': quantity,
        'model': model,
        'detail': detail,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar tinta');
    }
  }

  // Actualizar tinta de una impresora
  Future<void> updateInk(int inkId, int quantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/tintas/$inkId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar tinta');
    }
  }

  // Eliminar tinta de una impresora
  Future<void> deleteInk(int inkId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/tintas/$inkId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar tinta');
    }
  }
}
