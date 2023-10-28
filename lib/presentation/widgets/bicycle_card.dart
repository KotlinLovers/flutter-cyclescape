import 'package:cyclescape/domain/domain.dart';
import 'package:flutter/material.dart';

class BicycleCard extends StatelessWidget {
  final Bicycle bicycle;
  const BicycleCard({super.key, required this.bicycle});

  @override
  Widget build(BuildContext context) {
        return Column(
      children: [
        _ImageViewer( ),
        Text( bicycle.bicycleName, textAlign: TextAlign.center, ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
