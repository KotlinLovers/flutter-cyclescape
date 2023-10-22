
import 'package:cyclescape/domain/domain.dart';

abstract class AuthDataSource {
  Future<UserResponse> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<UserResponse> checkAuthStatus(String token);
}