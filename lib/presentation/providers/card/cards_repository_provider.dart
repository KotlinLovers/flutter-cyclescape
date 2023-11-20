
import 'package:cyclescape/domain/repositories/card_repository.dart';
import 'package:cyclescape/infrastructure/datasources/card_datasource_impl.dart';
import 'package:cyclescape/infrastructure/repositories/card_repository_impl.dart';
import 'package:cyclescape/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardsRepositoryProvider = Provider<CardRepository>((ref){
  final accessToken = ref.watch(authProvider).token;
  final cardsRepository = CardRepositoryImpl(CardDatasourceImpl(accessToken: accessToken));
  return cardsRepository;
});