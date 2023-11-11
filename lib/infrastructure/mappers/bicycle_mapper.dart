import 'package:cyclescape/domain/domain.dart';
import 'package:cyclescape/infrastructure/infrastructure.dart';

class BicycleMapper {
  static Bicycle jsonToEntity(Map<String, dynamic> json) => Bicycle(
        bicycleId: json['id'],
        bicycleName: json['bicycleName'],
        bicycleDescription: json['bicycleDescription'],
        bicyclePrice: double.parse(json['bicyclePrice'].toString()),
        bicycleSize: json['bicycleSize'],
        bicycleModel: json['bicycleModel'],
        imageData: json['imageData'],
        latitudeData: double.parse(json['latitude'].toString()),
        longitudeData: double.parse(json['longitude'].toString()),
        user: UserMapper.userInfoJsonToEntity(json['userDtoResponse']),
      );
  static BicycleDto dtoJsonToEntity(Map<String, dynamic> json) => BicycleDto(
        bicycleId: json['id'],
        bicycleName: json['bicycleName'],
        bicycleDescription: json['bicycleDescription'],
        bicyclePrice: double.parse(json['bicyclePrice'].toString()),
        bicycleSize: json['bicycleSize'],
        bicycleModel: json['bicycleModel'],
        imageData: json['imageData'],
        latitudeData: double.parse(json['latitude'].toString()),
        longitudeData: double.parse(json['longitude'].toString()),
      );
}
