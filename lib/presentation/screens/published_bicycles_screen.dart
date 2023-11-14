import 'package:cyclescape/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PublishedBicyclesScreen extends ConsumerStatefulWidget {
  final UserDto user;
  const PublishedBicyclesScreen({required this.user, super.key});

  @override
  PublishedBicyclesScreenState createState() => PublishedBicyclesScreenState();
}

class PublishedBicyclesScreenState extends ConsumerState<PublishedBicyclesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double rowWidth = screenWidth * 0.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bicicletas publicadas'),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.upload),
          ),],
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: ListView.builder(
        itemCount: widget.user.bicycles.length,
        itemBuilder: (context, index) {
          final bicycle = widget.user.bicycles[index];
          return ListTile(
            onTap: () {
              context.push('/bicycle/${bicycle.bicycleId}');
            },
            leading: Hero(
              tag: bicycle.bicycleId,
              child: Image.network(
                bicycle.imageData,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            title: Text(bicycle.bicycleName),
            subtitle: Text(bicycle.bicycleDescription),
            trailing: SizedBox(
              width: rowWidth,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // Lógica para editar
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      // Lógica para borrar
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
