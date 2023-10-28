import 'package:cyclescape/domain/domain.dart';

class BicycleRepositoryImpl extends BicycleRepository {
  final BicycleDatasource datasource;

  BicycleRepositoryImpl(this.datasource);

  @override
  Future<Bicycle> createBicycle(String id, Bicycle bicycle) {
    return createBicycle(id, bicycle);
  }

  @override
  Future<Bicycle> deleteBicycle(String id, Bicycle bicycle) {
    return datasource.deleteBicycle(id, bicycle);
  }

  @override
  Future<Bicycle> getBicycleById(String id) {
    return datasource.getBicycleById(id);
  }

  @override
  Future<List<Bicycle>> getBicycles() {
    return datasource.getBicycles();
  }

  @override
  Future<List<Bicycle>> searchBicycleByTerm(String term) {
    return datasource.searchBicycleByTerm(term);
  }

  @override
  Future<Bicycle> updateBicycle(String id, Bicycle bicycle) {
    return datasource.updateBicycle(id, bicycle);
  }
}