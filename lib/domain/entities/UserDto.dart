import 'bicycle.dart';
import 'card.dart';

class UserDto{
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String userPhone;
  final String userBirthDate;
  final double latitudeData;
  final double longitudeData;
  final String imageData;
  final List<Bicycle> bicycles;
  final List<Card> cards;

  UserDto({
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhone,
    required this.userBirthDate,
    required this.latitudeData,
    required this.longitudeData,
    required this.imageData,
    required this.bicycles,
    required this.cards
  });
}