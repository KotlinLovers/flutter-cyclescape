
import 'package:cyclescape/domain/domain.dart';

abstract class AuthDataSource {
  Future<UserResponse> login(String email, String password);
  Future<UserResponse> register(String email, String password, String confirmPassword ,String fullName);
}