import 'dart:convert';
import 'package:http/http.dart' as http;
import 'estado.dart';

class ApiService {
  static const String url =
      'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

  static Future<List<Estado>> fetchEstados() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((estado) => Estado.fromJson(estado)).toList();
    } else {
      throw Exception('Failed to load estados');
    }
  }
}
