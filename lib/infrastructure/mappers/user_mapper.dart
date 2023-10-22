import 'package:cyclescape/domain/domain.dart';

class UserMapper {
  static UserResponse userJsonToEntity(Map<String, dynamic> json) =>
      UserResponse(
          userId: json['user_id'],
          token: json['access_token'],
          refreshToken: json['refresh_token']);
}
