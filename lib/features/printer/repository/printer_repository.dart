import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muni_stock/features/printer/models/impresora_model.dart';

class PrinterRepository {
  final _apiUrl = "https://muniupala.go.cr/stock/impresoras.php";

  Future<List<ImpresoraModel>> getAll() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return impresoramOdelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> post(ImpresoraModel model) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model.toJson()),
    );

    return (response.statusCode == 200);
  }

  Future<bool> delete(String serie) async {
    final response = await http.delete(
      Uri.parse(_apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"serie": serie}),
    );

    return (response.statusCode == 200);
  }
}
