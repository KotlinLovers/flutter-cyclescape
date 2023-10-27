import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:cyclescape/shared/services/key_value_storage_service.dart';
import 'package:cyclescape/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

//! 1 - Inicializamos el state
//Creas una clase para representar el estado de tu aplicación.

enum AuthStatus { checking, authenticated, notAunthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserResponse? user;
  final String token;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.token = '',
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    UserResponse? user,
    String? errorMessage,
    String? token,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        token: token ?? this.token,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

//! 2 - Crear un Notificador de Estado
//Creas una clase que extiende StateNotifier y toma tu estado como parámetro
//Esta clase contiene la lógica para cambiar el estado y notificar a los oyentes sobre los cambios.

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorage keyValueStorageService;

  AuthNotifier(
      {required this.keyValueStorageService, required this.authRepository})
      : super(AuthState()) {
    checkToken();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 5600));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUsers(user);
    } on WrongCredentials {
      logOut('Credenciales no son correctas');
    } on ConnectioTimeOut {
      logOut('TimeOut');
    } catch (e) {
      logOut('Error no controlado');
    }
  }

  void registerUser(String email, String password, String fullName) async {}

  Future<void> logOut([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');
    state = state.copyWith(
      authStatus: AuthStatus.notAunthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void checkToken() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) {
      return logOut();
    } else {
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        token: token,
      );
    }
  }

  void _setLoggedUsers(UserResponse user) async {
    await keyValueStorageService.setKeyValue('token', user.token);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      token: user.token,
    );
  }
}

//! Proporcionar el Notificador de Estado
//Usas un StateNotifierProvider para proporcionar tu notificador de estado a tu árbol de widgets

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageImpl();
  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});
