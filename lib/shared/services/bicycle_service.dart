import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/bicycles.dart';
import '../../shared/services/key_value_storage_service_impl.dart';


class BicycleService {
  final String _baseUrl = 'http://localhost:8080/api/cyclescape/v1/bicycles';
  final http.Client httpClient;
  final KeyValueStorageImpl keyValueStorage;

  BicycleService({required this.httpClient, required this.keyValueStorage});

  Future<String> _getToken() async {
    return await keyValueStorage.getValue<String>('jwt_token') ?? '';
  }

  // Método para obtener todas las bicicletas con autorización JWT
  Future<List<Bicycle>> getAllBicycles() async {
    final token = await _getToken();
    final response = await httpClient.get(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> bicyclesJson = json.decode(response.body);
      return bicyclesJson.map((json) => Bicycle.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las bicicletas: ${response.statusCode}');
    }
  }

  // Método para agregar una bicicleta
  Future<Bicycle> addBicycle(Bicycle bicycle) async {
    final token = await _getToken();
    final response = await httpClient.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(bicycle.toJson()),
    );

    if (response.statusCode == 201) {
      return Bicycle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al agregar bicicleta: ${response.statusCode}');
    }
  }



  // Método para actualizar una bicicleta
  Future<Bicycle> updateBicycle(Bicycle bicycle) async {
    final token = await _getToken();
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/${bicycle.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(bicycle.toJson()),
    );

    if (response.statusCode == 200) {
      return Bicycle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar la bicicleta: ${response.statusCode}');
    }
  }

  // Método para eliminar una bicicleta
  Future<void> deleteBicycle(int id) async {
    final token = await _getToken();
    final response = await httpClient.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la bicicleta: ${response.statusCode}');
    }
  }
}
