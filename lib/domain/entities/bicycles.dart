class Bicycle {
  final int? id;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;

  Bicycle({
    this.id, // id es opcional para permitir instancias sin id (nuevas bicicletas)
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    required this.imageData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['bicycleName'] = this.bicycleName;
    data['bicycleDescription'] = this.bicycleDescription;
    data['bicyclePrice'] = this.bicyclePrice;
    data['bicycleSize'] = this.bicycleSize;
    data['bicycleModel'] = this.bicycleModel;
    data['imageData'] = this.imageData;
    return data;
  }

  factory Bicycle.fromJson(Map<String, dynamic> json) {
    return Bicycle(
      id: json['id'],
      bicycleName: json['bicycleName'],
      bicycleDescription: json['bicycleDescription'],
      bicyclePrice: json['bicyclePrice'],
      bicycleSize: json['bicycleSize'],
      bicycleModel: json['bicycleModel'],
      imageData: json['imageData'],
    );
  }
}
