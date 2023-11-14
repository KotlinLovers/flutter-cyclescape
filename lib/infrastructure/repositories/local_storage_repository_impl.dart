
import 'package:cyclescape/domain/datasources/local_storage_datasource.dart';
import 'package:cyclescape/domain/entities/bicycleDto.dart';
import 'package:cyclescape/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isFavorite(int bicycleId) {
    return datasource.isFavorite(bicycleId);
  }
  
  @override
  Future<List<BicycleDto>> loadBicycles() {
    return datasource.loadBicycles();
  }

  @override
  Future<void> toggleFavorite(BicycleDto bicycle) {
    return datasource.toggleFavorite(bicycle);
  }

  Future<void> removeFromFavorites(BicycleDto bicycle) {
    return datasource.removeFromFavorites(bicycle);
  }

}