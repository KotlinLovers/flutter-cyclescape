import '../domain.dart';

abstract class BicycleDatasource {
  Future<List<Bicycle>> getBicycles();
  Future<Bicycle> getBicycleById(int id);
  Future<List<Bicycle>> searchBicycleByTerm(String term);
  Future<Bicycle> createBicycle(String id, Bicycle bicycle);
  Future<Bicycle> updateBicycle(String id, Bicycle bicycle);
  Future<Bicycle> deleteBicycle(String id, Bicycle bicycle);
}
