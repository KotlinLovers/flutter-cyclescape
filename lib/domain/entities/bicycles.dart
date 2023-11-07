// bicycle.dart

class Bicycle {
  final int id;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;

  Bicycle(
      this.id,
      this.bicycleName,
      this.bicycleDescription,
      this.bicyclePrice,
      this.bicycleSize,
      this.bicycleModel,
      this.imageData,
      );

  factory Bicycle.fromJson(Map<String, dynamic> json) {
    return Bicycle(
      json['id'],
      json['bicycleName'],
      json['bicycleDescription'],
      json['bicyclePrice'],
      json['bicycleSize'],
      json['bicycleModel'],
      json['imageData'],
    );

  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'bicycleName': bicycleName,
    'bicycleDescription': bicycleDescription,
    'bicyclePrice': bicyclePrice,
    'bicycleSize': bicycleSize,
    'bicycleModel': bicycleModel,
    'imageData': imageData,
  };
}
