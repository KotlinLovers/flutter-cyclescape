import 'package:cyclescape/domain/domain.dart';
import 'package:cyclescape/presentation/providers/bicycle/bicycle_form_provider.dart';
import 'package:cyclescape/presentation/providers/bicycle/bicycle_provider.dart';
import 'package:cyclescape/shared/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../shared/shared.dart';
import '../../providers/providers.dart';

class EditBicycleScreen extends ConsumerWidget {
  final int bicycleId;

  const EditBicycleScreen({super.key, required this.bicycleId});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3)
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bicycleState = ref.watch(bicycleProvider(bicycleId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar bicicleta'),
        leading: IconButton(
          onPressed: () async {
            context.pop(context);
          },
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
        onPressed: () async {
          if (bicycleState.bicycle == null) return;
          await ref
              .read(
                bicycleFormProvider(bicycleState.bicycle!).notifier,
              )
              .onFormSubmit().then((value) {
                if (!value) {
                  showSnackBar(context, 'Bicicleta actualizada');
                } else {
                  showSnackBar(context, 'Error al actualizar bicicleta');
                }
              });

          await ref.read(userProvider.notifier).getUserById();
        },
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {
  final BicycleDto bicycle;
  const _ProductView({required this.bicycle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bicycleForm = ref.watch(bicycleFormProvider(bicycle));
    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
            height: 250,
            width: 600,
            child: Image.network(bicycleForm.imageData)),
        const SizedBox(height: 10),
        Center(
            child: Text(bicycleForm.title.value, style: textStyles.titleSmall)),
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
    final bicycleForm = ref.watch(bicycleFormProvider(bicycle));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CustomBicycleField(
            isTopField: true,
            label: 'Nombre',
            initialValue: bicycleForm.title.value,
            onChanged:
                ref.read(bicycleFormProvider(bicycle).notifier).onTitleChanged,
            errorMessage: bicycleForm.title.errorMessage,
          ),
          CustomBicycleField(
            isTopField: false,
            maxLines: 1,
            label: 'Descripción',
            initialValue: bicycleForm.description,
            onChanged: (value) => ref
                .read(bicycleFormProvider(bicycle).notifier)
                .onDescriptionChanged(value),
            errorMessage: bicycleForm.title.errorMessage,
          ),
          CustomBicycleField(
            isTopField: false,
            label: 'Modelo',
            initialValue: bicycleForm.model.value,
            onChanged: (value) => ref
                .read(bicycleFormProvider(bicycle).notifier)
                .onModelChanged(value),
            errorMessage: bicycleForm.model.errorMessage,
          ),
          CustomBicycleField(
            isBottomField: false,
            label: 'Precio - Soles',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: bicycleForm.price.value.toString(),
            onChanged: (value) => ref
                .read(bicycleFormProvider(bicycle).notifier)
                .onPriceChanged(double.tryParse(value) ?? -1),
            errorMessage: bicycleForm.price.errorMessage,
          ),
          CustomBicycleField(
            isBottomField: true,
            label: 'Tamaño - Metros',
            initialValue: bicycleForm.size,
            onChanged: (value) => ref
                .read(bicycleFormProvider(bicycle).notifier)
                .onSizeChanged(value),
            errorMessage: bicycleForm.title.errorMessage,
          ),
        ],
      ),
    );
  }
}
