import 'package:cyclescape/shared/util/util.dart';

class BicycleFormState {
  final bool isFormValid;
  final int? id;
  final Title title;
  final Price price;
  final String description;
  final String size;
  final String model;
  final String imageData;
  final double latitude;
  final double longitude;

  BicycleFormState(
      {this.isFormValid = false,
      this.id,
      this.title = const Title.dirty(''),
      this.price = const Price.dirty(0),
      this.description = '',
      this.size = '',
      this.model = '',
      this.imageData = '',
      this.latitude = 0.0,
      this.longitude = 0.0});
  
  BicycleFormState copyWith({
    bool? isFormValid,
    int? id,
    Title? title,
    Price? price,
    String? description,
    String? size,
    String? model,
    String? imageData,
    double? latitude,
    double? longitude,
  }) {
    return BicycleFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      size: size ?? this.size,
      model: model ?? this.model,
      imageData: imageData ?? this.imageData,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
