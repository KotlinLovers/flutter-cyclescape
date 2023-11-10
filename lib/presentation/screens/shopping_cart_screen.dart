import 'package:cyclescape/shared/util/shared_entities/bicycle_shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Carrito de compras"),
        leading: IconButton(
            onPressed: () {
              if (context.canPop()) {
                return context.pop();
              }
              context.go('/');
            },
            icon: const Icon(LineAwesomeIcons.angle_left,
                size: 30, color: Colors.black)),
      ),
      body: bicycles!.isEmpty
          ? const Center(
              child: Text("Carrito vacío...", style: TextStyle(fontSize: 20)),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 50.0,
                  floating: false,
                  pinned: true,
                  title: Row(
                    children: [
                      Text("Total: $totalPrice"),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text("Continuar compra"),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final bicycle = bicycles![index];
                      return GestureDetector(
                        onTap: () {
                          context.go('/bicycle/${bicycle.bicycleId}');
                        },
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  bicycle.imageData,
                                  fit: BoxFit.contain,
                                  width: 100, // Adjust the height as needed
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(bicycle.bicycleName),
                                    Text('${bicycle.bicyclePrice}'),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      bicycles!.remove(bicycle);
                                      updateTotalPrice(
                                          bicycle.bicyclePrice * -1.0);
                                    });
                                  },
                                  child: const Icon(Icons.cancel,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: bicycles!.length,
                  ),
                ),
              ],
            ),
    );
  }
}
