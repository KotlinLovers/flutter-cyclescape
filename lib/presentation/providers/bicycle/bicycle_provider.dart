import 'package:cyclescape/domain/domain.dart';
import 'package:cyclescape/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//autodispose->limpia cuando no se usa
final bicycleProvider = StateNotifierProvider.autoDispose
    .family<BicycleNotifier, BicycleState, int>((ref, bicycleId) {
  return BicycleNotifier(
    bicycleRepository: ref.watch(bicyclesRepositoryProvider),
    bicycleId: bicycleId,
  );
});

class BicycleNotifier extends StateNotifier<BicycleState> {
  final BicycleRepository bicycleRepository;

  BicycleNotifier({
    required this.bicycleRepository,
    required int bicycleId,
  }) : super(BicycleState(id: bicycleId)){
    loadBicycle();
  }

  Future<void> loadBicycle() async {
    try {
      state = state.copyWith(isLoading: true);
      final bicycle = await bicycleRepository.getBicycleById(state.id);
      state = state.copyWith(bicycle: bicycle.toDto(), isLoading: false);
    } catch (e) {
      print(e);
    }
  }
}

class BicycleState {
  final int id;
  final BicycleDto? bicycle;
  final bool isLoading;
  final bool isSaving;

  BicycleState(
      {required this.id,
      this.bicycle,
      this.isLoading = true,
      this.isSaving = false});

  BicycleState copyWith({
    int? id,
    BicycleDto? bicycle,
    bool? isLoading,
    bool? isSaving,
  }) =>
      BicycleState(
        id: id ?? this.id,
        bicycle: bicycle ?? this.bicycle,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
