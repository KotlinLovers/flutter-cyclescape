import 'package:cyclescape/config/config.dart';
import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

import '../../domain/domain.dart';

class BicycleDatasourceImpl extends BicycleDatasource {
  late final Dio dio;
  final String accessToken;
  final int? userId;

  BicycleDatasourceImpl({required this.accessToken, this.userId})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

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
  Future<Bicycle> updateOrCreateBicycle(Map<String, dynamic> bicycleLike) async {
    try {
      Response response;
      if (bicycleLike.containsKey('id') && bicycleLike['id'] != null) {
        response = await dio.request( 
          '/bicycles/${bicycleLike['id']}',
          data: bicycleLike,
          options: Options(method: 'PUT'),
        );
      } else {
        bicycleLike.remove('id');
        if (userId == null) {
          throw ArgumentError('userId is required for creating a new bicycle');
        }
        response = await dio.post('/bicycles/user/$userId', data: bicycleLike);
      }

      final bicycle = BicycleMapper.jsonToEntity(response.data);
      return bicycle;
    } catch (e) {
      throw Exception();
    }
  }
}
