import 'package:cyclescape/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/infrastructure.dart';
import 'bicycles_repository_provider.dart';

final bicyclesProvider = StateNotifierProvider<BicyclesNotifier, BicycleState>(
    (ref) => BicyclesNotifier(
        bicycleRepository: ref.watch(bicyclesRepositoryProvider)));

class BicyclesNotifier extends StateNotifier<BicycleState> {
  final BicycleRepository bicycleRepository;
  BicyclesNotifier({required this.bicycleRepository}) : super(BicycleState.initial()) {
    getBicycles();
  }

  Future<void> getBicycles() async {
    final bicycles = await bicycleRepository.getBicycles();
    state = state.copyWith(bicycles: bicycles);
  }

  Future<Bicycle> getBicycleById(int id) async {
    // This function now only fetches and returns a bicycle, not affecting the state
    return await bicycleRepository.getBicycleById(id);
  }
}

class BicycleState {
  final List<Bicycle> bicycles;

  BicycleState({this.bicycles = const []});

  // Factory constructor for initial state
  factory BicycleState.initial() {
    return BicycleState(bicycles: []);
  }

  BicycleState copyWith({
    List<Bicycle>? bicycles,
  }) {
    return BicycleState(
      bicycles: bicycles ?? this.bicycles,
    );
  }
}
