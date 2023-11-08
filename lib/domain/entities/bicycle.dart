import 'package:cyclescape/domain/domain.dart';

class Bicycle {
  final int bicycleId;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;
  final double latitudeData;
  final double longitudeData;
  final User user;

  Bicycle({
    required this.bicycleId,
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    required this.imageData,
    required this.latitudeData,
    required this.longitudeData,
    required this.user,
  });
}
