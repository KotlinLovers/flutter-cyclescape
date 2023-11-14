import 'package:cyclescape/domain/entities/bicycleDto.dart';
import 'package:cyclescape/presentation/providers/favorite_bicycles_provider.dart';
import 'package:cyclescape/presentation/providers/local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  List<BicycleDto>? bicycleDetail;

  @override
  void initState() {
    super.initState();
    loadFavoriteBicycle();
  }

  Future<void> loadFavoriteBicycle() async {
    final bicycle =
        await ref.read(storageBicyclesProvider.notifier).loadNextPage();
    if (mounted) {
      setState(() {
        bicycleDetail = bicycle;
      });
    }
  }

  final isFavoriteProvider =
      FutureProvider.family.autoDispose((ref, int bicycleId) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);
    return localStorageRepository.isFavorite(bicycleId);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: ListView.builder(
        itemCount: bicycleDetail?.length ?? 0,
        itemBuilder: (context, index) {
          final bicycle = bicycleDetail?[index];
          return Dismissible(
            key: Key(bicycle!.bicycleId.toString()),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            onDismissed: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                await ref
                    .read(localStorageRepositoryProvider)
                    .removeFromFavorites(bicycle);
                setState(() {
                  bicycleDetail?.removeAt(index);
                });
              } else {}
            },
            child: Card(
              elevation: 0,
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: ListTile(
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
                onTap: () {
                  context.push('/bicycle/${bicycle.bicycleId}');
                },
                trailing: const Icon(LineAwesomeIcons.angle_right),
              ),
            ),
          );
        },
      ),
    );
  }
}
