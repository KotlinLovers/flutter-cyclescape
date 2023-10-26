import '../../domain/domain.dart';
import '../datasources/user_datasource_impl.dart';
import '../infrastructure.dart';

class UserRepositoryImpl extends UserRepository {

  final UserDataSource dataSource;

  UserRepositoryImpl({UserDataSource? dataSource})
      : dataSource = dataSource ?? UserDataSourceImpl();

  @override
  Future<UserDto> getUserById(int userId) {
    return dataSource.getUserById(userId);
  }

  @override
  Future<User> updateUser(int userId, User user) {
    return dataSource.updateUser(userId, user);
  }
}
