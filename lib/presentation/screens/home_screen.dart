import 'package:flutter/material.dart';

import '../../shared/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('no quiero vivir'));
  }
}