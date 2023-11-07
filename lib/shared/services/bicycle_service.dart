import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/bicycles.dart';

class ApiService {

  final String baseUrl ='http://localhost:8080/api/cyclescape/v1/bicycles';
  //final String baseUrl ='http://localhost:8082/api/bicycles';
  //final String baseUrl ='http://10.11.148.48:8082/api/bicycles';

  Future<List<Bicycle>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Bicycle.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Bicycles');
    }
  }

  Future<Bicycle> createItem(Bicycle item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Bicycle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create Bicycle');
    }
  }

  Future<Bicycle> updateBicycle(int id, Bicycle item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return Bicycle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<bool> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true; // El bicye fue eliminado correctamente
    } else {
      throw Exception('Failed to delete item');
    }
  }

}
