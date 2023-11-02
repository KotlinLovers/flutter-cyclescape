import 'package:cyclescape/domain/entities/bicycle.dart';
import 'package:cyclescape/presentation/providers/bicycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BicycleDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const BicycleDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<BicycleDetailScreen> createState() => _BicycleDetailScreenState();
}

class _BicycleDetailScreenState extends ConsumerState<BicycleDetailScreen> {
  Bicycle? bicycleDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBicycleDetail();
  }

  Future<void> loadBicycleDetail() async {
    try {
      final bicycle = await ref.read(bicyclesProvider.notifier).getBicycleById(widget.id);
      if (mounted) {
        setState(() {
          bicycleDetail = bicycle;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: const Text('Bicycle Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bicycleDetail == null
              ? Center(child: Text('Bicycle not found'))
              : ListView(
                  children: [
                    Image.network(bicycleDetail!.imageData),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(bicycleDetail!.bicycleName),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Price: ${bicycleDetail!.bicyclePrice}'),
                    ),
                    // Add more details as needed.
                  ],
                ),
    );
  }
}
