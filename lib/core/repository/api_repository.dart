import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muni_stock/core/repository/api_interface.dart';

class ApiRepository<T> implements IApi<T> {
  final String apiUrl;
  final T Function(Map<String, dynamic>) fromJson;
  final String? token; // Token opcional

  ApiRepository(this.apiUrl, this.fromJson, {this.token});

  Map<String, String> _getHeaders() {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null && token!.isNotEmpty) {
      headers['Authorization'] =
          'Bearer $token'; // Si el token está disponible, lo añadimos
    }
    return headers;
  }

  @override
  Future<List<T>> getAll() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: _getHeaders(), // Agregamos los headers
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener datos');
    }
  }

  @override
  Future<T?> getById(int id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$id'),
      headers: _getHeaders(),
    );
    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener datos por ID');
    }
  }

  @override
  Future<void> post(T item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: _getHeaders(),
      body: json.encode(item),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al añadir nuevo elemento');
    }
  }

  @override
  Future<void> update(T item) async {
    final response = await http.put(
      Uri.parse(
          '$apiUrl/${(item as dynamic).id}'), // Se asume que el objeto tiene un ID
      headers: _getHeaders(),
      body: json.encode(item),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el elemento');
    }
  }

  @override
  Future<void> delete(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: _getHeaders(),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el elemento');
    }
  }
}
