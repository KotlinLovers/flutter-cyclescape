import 'package:cyclescape/domain/domain.dart';

abstract class UserDataSource{
  Future<UserDto> getUserById(int userId);
  Future<User> updateUser(int userId, User user);
}