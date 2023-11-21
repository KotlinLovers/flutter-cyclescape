import 'package:cyclescape/infrastructure/datasources/isar_datasource.dart';
import 'package:cyclescape/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
