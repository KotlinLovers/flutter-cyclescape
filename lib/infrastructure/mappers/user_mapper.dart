import 'package:cyclescape/domain/domain.dart';

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
        latitudeData: json['latitudeData'],
        longitudeData: json['longitudeData'],
        imageData: json['imageData'],
        bicycles: json['bicycles'],
        cards: json['cards']
      );


}

