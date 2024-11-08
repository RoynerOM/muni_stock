import 'package:http/http.dart' as http;
import 'package:muni_stock/features/consumable/models/consumable_model.dart';

class ConsmableRepository {
  final _apiUrl =
      "https://muniupala.go.cr/stock/index.php?endpoint=consumibles";

  Future<List<ConsumableModel>> getAll() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return consumableFromJson(response.body);
    } else {
      return [];
    }
  }
}
