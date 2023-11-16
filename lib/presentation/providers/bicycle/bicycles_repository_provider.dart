import 'package:cyclescape/domain/domain.dart';
import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:cyclescape/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final bicyclesRepositoryProvider = Provider<BicycleRepository>((ref) {
  final accessToken = ref.watch(authProvider).token;
  final bicyclesRepository =
      BicycleRepositoryImpl(BicycleDatasourceImpl(accessToken: accessToken));
  return bicyclesRepository;
});

