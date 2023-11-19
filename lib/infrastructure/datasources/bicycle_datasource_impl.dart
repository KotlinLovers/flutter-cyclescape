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
  Future<Bicycle> createBicycle(Map<String, dynamic> bicycleLike) async{
    try {
      final response = await dio.post('/bicycles', data: bicycleLike);
      final bicycle = BicycleMapper.jsonToEntity(response.data);
      return bicycle;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Bicycle> deleteBicycle(int id) {
    // TODO: implement deleteBicycle
    throw UnimplementedError();
  }

  @override
  Future<Bicycle> getBicycleById(int id) async {
    try {
      final response = await dio.get('/bicycles/bike/$id');
      return BicycleMapper.jsonToEntity(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw BicycleNotFound();
      throw Exception();
    }
  }

  @override
  Future<List<BicycleDto>> getBicycles() async {
    final response = await dio.get<List>('/bicycles');
    final List<BicycleDto> bicycles = [];
    for (final bicycle in response.data ?? []) {
      bicycles.add(BicycleMapper.dtoJsonToEntity(bicycle));
    }
    return bicycles;
  }

  @override
  Future<List<Bicycle>> searchBicycleByTerm(String term) {
    // TODO: implement searchBicycleByTerm
    throw UnimplementedError();
  }

  @override
  Future<Bicycle> updateBicycle(Map<String, dynamic> bicycleLike) async {
    try {
      final response = await dio.request(
        '/bicycles/${bicycleLike['id']}',
        data: bicycleLike,
        options: Options(method: 'PUT'),
      );
      final bicycle = BicycleMapper.jsonToEntity(response.data);
      return bicycle;
    } catch (e) {
      throw Exception();
    }
  }
}
