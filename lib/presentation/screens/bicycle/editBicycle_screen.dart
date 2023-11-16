import 'package:cyclescape/domain/domain.dart';
import 'package:cyclescape/presentation/providers/bicycle/bicycle_provider.dart';
import 'package:cyclescape/shared/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../shared/shared.dart';

class EditBicycleScreen extends ConsumerWidget {
  final int bicycleId;

  const EditBicycleScreen({super.key, required this.bicycleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bicycleState = ref.watch(bicycleProvider(bicycleId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar bicicleta'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
      body: bicycleState.isLoading
          ? const LoadingScreen()
          : _ProductView(bicycle: bicycleState.bicycle!),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}

class _ProductView extends StatelessWidget {
  final BicycleDto bicycle;
  const _ProductView({required this.bicycle});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
            height: 250, width: 600, child: Image.network(bicycle.imageData)),
        const SizedBox(height: 10),
        Center(child: Text(bicycle.bicycleName, style: textStyles.titleSmall)),
        const SizedBox(height: 10),
        _ProductInformation(bicycle: bicycle),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  final BicycleDto bicycle;
  const _ProductInformation({required this.bicycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CustomBicycleField(
            isTopField: true,
            label: 'Nombre',
            initialValue: bicycle.bicycleName,
          ),
          CustomBicycleField(
            isTopField: false,
            maxLines: 2,
            label: 'Descripción',
            initialValue: bicycle.bicycleDescription,
          ),
          CustomBicycleField(
            isTopField: false,
            label: 'Modelo',
            initialValue: bicycle.bicycleModel,
          ),
          CustomBicycleField(
            isBottomField: false,
            label: 'Precio - Soles',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: bicycle.bicyclePrice.toString(),
          ),
          CustomBicycleField(
            isBottomField: true,
            label: 'Tamaño - Metros',
            initialValue: bicycle.bicycleSize,
          ),
        ],
      ),
    );
  }
}
