import 'package:http/http.dart' as http;
import 'package:muni_stock/features/consumable/models/impresora_model.dart';

class ConsmableRepository {
  final _apiUrl = "https://muniupala.go.cr/stock/impresoras.php";

  Future<List<ImpresoraModel>> getAll() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return impresoramOdelFromJson(response.body);
    } else {
      return [];
    }
  }
}
