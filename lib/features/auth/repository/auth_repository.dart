import 'dart:convert';

import 'package:muni_stock/core/repository/api_repository.dart';
import 'package:muni_stock/features/auth/models/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String?> login(AuthModel auth) async {
    try {
      final response = await http.post(
        Uri.parse('https://muniupala.go.cr/stock/index.php?endpoint=login'),
        body: json.encode(auth.toLogin()),
      );
      if (response.statusCode != 200) return null;

      final responseData = json.decode(response.body);

      return responseData['token'] as String?;
    } catch (e) {
      return null;
    }
  }

  final postRegister = ApiRepository<AuthModel>(
    'https://muniupala.go.cr/stock/index.php?endpoint=usuarios',
    (json) => AuthModel.fromJson(json),
  );

  Future<void> regsiter(AuthModel model) async {
    try {
      await postRegister.post(model);
    } catch (e) {
      throw Exception(e);
    }
  }
}
