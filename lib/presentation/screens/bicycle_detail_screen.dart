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
  ConsumerState<BicycleDetailScreen> createState() =>
      _BicycleDetailScreenState();
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
      final bicycle =
          await ref.read(bicyclesProvider.notifier).getBicycleById(widget.id);
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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text('${bicycleDetail?.bicycleName ?? 'Cargando...'}'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bicycleDetail == null
              ? Center(child: Text('Bicycle not found'))
              : ListView(
                  children: [
                    ImageSection(bicycleDetail: bicycleDetail!),
                    DescriptionSection(
                      textTheme: textTheme,
                      description: bicycleDetail!.bicycleDescription,
                    ),
                    PriceSection(price: bicycleDetail!.bicyclePrice),
                    InformationSection(
                      label: 'Model',
                      value: bicycleDetail!.bicycleModel,
                      icon: LineAwesomeIcons.bicycle,
                    ),
                    InformationSection(
                      label: 'Size',
                      value: bicycleDetail!.bicycleSize,
                      icon: LineAwesomeIcons.text_height,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: FilledButton(
                                onPressed: () {},
                                child: const Text('Comprar'),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  LineAwesomeIcons.shopping_cart_arrow_down,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final Bicycle bicycleDetail;

  const ImageSection({Key? key, required this.bicycleDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Hero(
        tag: bicycleDetail.bicycleId,
        child: Image.network(
          bicycleDetail.imageData,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final TextTheme textTheme;
  final String description;

  const DescriptionSection({
    Key? key,
    required this.textTheme,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        style: textTheme.titleMedium,
      ),
    );
  }
}

class PriceSection extends StatelessWidget {
  final double price;

  const PriceSection({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'S/${price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 24.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}

class InformationSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InformationSection({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
