import 'package:cyclescape/config/config.dart';
import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

import '../../domain/domain.dart';

class BicycleDatasourceImpl extends BicycleDatasource {
  late final Dio dio;
  final String accessToken;

  BicycleDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<Bicycle> createBicycle(String id, Bicycle bicycle) {
    // TODO: implement createBicycle
    throw UnimplementedError();
  }

  @override
  Future<Bicycle> deleteBicycle(String id, Bicycle bicycle) {
    // TODO: implement deleteBicycle
    throw UnimplementedError();
  }

  @override
  Future<Bicycle> getBicycleById(int id) async {
    try {
      final response = await dio.get('/bicycles/$id');
      return BicycleMapper.jsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw BicycleNotFound();
      throw Exception();
    }
  }

  @override
  Future<List<Bicycle>> getBicycles() async {
    final response = await  dio.get<List>('/bicycles');
    final List<Bicycle> bicycles = [];
    for (final bicycle in response.data ?? []) {
      bicycles.add(BicycleMapper.jsonToEntity(bicycle));
    }
    return bicycles;
  }

  @override
  Future<List<Bicycle>> searchBicycleByTerm(String term) {
    // TODO: implement searchBicycleByTerm
    throw UnimplementedError();
  }

  @override
  Future<Bicycle> updateBicycle(String id, Bicycle bicycle) {
    // TODO: implement updateBicycle
    throw UnimplementedError();
  }
}
