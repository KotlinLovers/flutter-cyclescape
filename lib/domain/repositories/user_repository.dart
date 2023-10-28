import '../domain.dart';

abstract class UserRepository {
  Future<UserDto> getUserById(int userId);
  Future<User> updateUser(int userId, User user);
}