import '../domain.dart';

abstract class AuthRepository {
  Future<UserResponse> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
}
