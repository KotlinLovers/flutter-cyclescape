

import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:cyclescape/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref){
    final accessToken = ref.read(authProvider).token;
    final userRepository = UserRepositoryImpl(token: accessToken);
    return userRepository;
});