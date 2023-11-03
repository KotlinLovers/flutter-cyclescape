import 'package:cyclescape/domain/domain.dart';

class BicycleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Bicycle(
      bicycleId: json['id'],
      bicycleName: json['bicycleName'],
      bicycleDescription: json['bicycleDescription'],
      bicyclePrice: double.parse(json['bicyclePrice'].toString()),
      bicycleSize: json['bicycleSize'],
      bicycleModel: json['bicycleModel'],
      imageData: json['imageData']
    );
}
