import 'package:cyclescape/domain/domain.dart';

List<Bicycle>? bicycles = List<Bicycle>.empty(growable: true);
double totalPrice = 0;
void updateTotalPrice(double price) {
  totalPrice += price;
  totalPrice = double.parse(totalPrice.toStringAsFixed(2));
}
