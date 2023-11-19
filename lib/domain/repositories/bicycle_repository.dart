import '../domain.dart';

abstract class BicycleRepository {
  Future<List<BicycleDto>> getBicycles();
  Future<Bicycle> getBicycleById(int id);
  Future<List<Bicycle>> searchBicycleByTerm(String term);
  Future<Bicycle> createBicycle(Map<String, dynamic> bicycleLike);
  Future<Bicycle> updateBicycle(Map<String, dynamic> bicycleLike);
  Future<Bicycle> deleteBicycle(int id);
}
