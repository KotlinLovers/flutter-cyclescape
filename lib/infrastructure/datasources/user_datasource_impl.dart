
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class UserDataSourceImpl extends UserDataSource {
  late final Dio dio;
  final String accessToken;

  UserDataSourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
        baseUrl: Environment.apiUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
  ));

  @override
  Future<UserDto> getUserById(int userId) async {
    try {
      final response = await dio.get('/users/$userId');
      final userDtoResponse = UserMapper.userDtoJsonToEntity(response.data);
      return userDtoResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) throw WrongCredentials();
      if (e.type == DioExceptionType.connectionTimeout) throw ConnectioTimeOut();

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





