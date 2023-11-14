import '../domain.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(BicycleDto bicycle);

  Future<bool> isFavorite(int bicycleId);

  Future<List<BicycleDto>> loadBicycles({int limit = 10,offset = 0});

  Future<void> removeFromFavorites(BicycleDto bicycle);
}