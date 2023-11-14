import 'package:cyclescape/domain/domain.dart';

List<BicycleDto>? bicycles = List<BicycleDto>.empty(growable: true);
double totalPrice = 0;
void updateTotalPrice(double price) {
  totalPrice += price;
  totalPrice = double.parse(totalPrice.toStringAsFixed(2));
}
