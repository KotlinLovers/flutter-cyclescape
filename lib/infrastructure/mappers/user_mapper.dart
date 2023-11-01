import 'package:cyclescape/domain/domain.dart';

import '../infrastructure.dart';

class UserMapper {
  static UserResponse userJsonToEntity(Map<String, dynamic> json) =>
      UserResponse(
          userId: json['user_id'],
          token: json['access_token'],
          refreshToken: json['refresh_token']);

  static UserDto userDtoJsonToEntity(Map<String,dynamic>json) =>
      UserDto(
        userFirstName: json['userFirstName'],
        userLastName: json['userLastName'],
        userEmail: json['userEmail'],
        userPhone: json['userPhone'],
        userBirthDate: json['userBirthDate'],
        latitudeData: (json['latitudeData'] is num) ? json['latitudeData'].toDouble() : 0.0,
        longitudeData: (json['longitudeData'] is num) ? json['longitudeData'].toDouble() : 0.0,
        imageData: json['imageData'],
        bicycles: List<Bicycle>.from(json['bicycles'].map((x) => BicycleMapper.jsonToEntity(x))),
        cards: List<Card>.from(json['cards'].map((x) => CardMapper.jsonToEntity(x))),
      );
}

