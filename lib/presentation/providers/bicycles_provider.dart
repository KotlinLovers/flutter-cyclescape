import 'package:cyclescape/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bicycles_repository_provider.dart';


final bicyclesProvider = StateNotifierProvider<BicyclesNotifier, BicycleState>(
    (ref) => BicyclesNotifier(
        bicycleRepository: ref.watch(bicyclesRepositoryProvider)));        


class BicyclesNotifier extends StateNotifier<BicycleState> {
  final BicycleRepository bicycleRepository;

  BicyclesNotifier({required this.bicycleRepository})
      : super(BicycleState()) {
    getBicycles();
  }

  Future<void> getBicycles() async {
    final bicycles = await bicycleRepository.getBicycles();
    state = state.copyWith(
      bicycles: bicycles
    );
  }
}


class BicycleState {
  final List<Bicycle> bicycles;

  BicycleState({
    this.bicycles = const [],
  });

  BicycleState copyWith({
    List<Bicycle>? bicycles,
  }) =>
      BicycleState(
        bicycles: bicycles ?? this.bicycles,
      );
}
