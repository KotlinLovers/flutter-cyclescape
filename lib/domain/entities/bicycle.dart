import 'package:equatable/equatable.dart';

class Bicycle extends Equatable {
  final String id;
  final String bicycleName;
  final String bicycleDescription;
  final double bicyclePrice;
  final String bicycleSize;
  final String bicycleModel;
  final String imageData;

  Bicycle({
    required this.id,
    required this.bicycleName,
    required this.bicycleDescription,
    required this.bicyclePrice,
    required this.bicycleSize,
    required this.bicycleModel,
    required this.imageData,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
