import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));
  @override
  Future<UserResponse> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login',
          data: {'userEmail': email, 'userPassword': password});
      final userResponse = UserMapper.userJsonToEntity(response.data);
      return userResponse;
    } on DioException catch (e) {
      if ((e.response?.statusCode == 401)) throw WrongCredentials();
      if ((e.type == DioExceptionType.connectionTimeout)) throw ConnectioTimeOut();

      throw CustomError(message: 'Something wrong happend', errorCode: 500);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
