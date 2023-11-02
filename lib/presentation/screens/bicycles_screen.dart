import 'package:cyclescape/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BicyclesScreen extends ConsumerStatefulWidget {
  const BicyclesScreen({super.key});

  @override
  BicyclesScreenState createState() => BicyclesScreenState();
}

class BicyclesScreenState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    ref.read(bicyclesProvider.notifier).getBicycles();
  }

  @override
  Widget build(BuildContext context) {
    final bicycleState = ref.watch(bicyclesProvider);
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final bicycle = bicycleState.bicycles[index];
            return GestureDetector(
              child: Card(
                elevation: 4, // Añade sombra
                shape: RoundedRectangleBorder(
                  // Bordado redondeado
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.network(
                          bicycle.imageData,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bicycle.bicycleName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'S/. ${bicycle.bicyclePrice.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: bicycleState.bicycles.length,
        ),
      ),
    );
  }
}
