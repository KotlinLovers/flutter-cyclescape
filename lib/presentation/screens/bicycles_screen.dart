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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: bicycleState.bicycles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final bicycle = bicycleState.bicycles[index];
            return GestureDetector(
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        bicycle.imageData,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bicycle.bicycleName,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'S/. ${bicycle.bicyclePrice.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
