
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSourceImpl extends UserDataSource{

  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  Future<void> setBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('token');

    if (authToken != null) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    }
  }

  @override
  Future<UserDto> getUserById(int userId) async{
    try {
      final response = await dio.get('/auth/users/$userId',
          );
      final userDtoResponse = UserMapper.userDtoJsonToEntity(response.data);
      return userDtoResponse;
    } on DioException catch (e) {
      if ((e.response?.statusCode == 500)) throw WrongCredentials();
      if ((e.type == DioExceptionType.connectionTimeout)) throw ConnectioTimeOut();

      throw CustomError(message: 'Cant get the user', errorCode: 500);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> updateUser(int userId, User user) {
    // TODO: implement UpdateUser
    throw UnimplementedError();
  }
  
}