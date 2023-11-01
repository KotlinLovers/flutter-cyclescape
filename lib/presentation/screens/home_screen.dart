import 'package:cyclescape/presentation/screens/screens.dart';
import 'package:cyclescape/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search_rounded)
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AdvertisementCards(),
          ),
          const BicyclesScreen(),
        ],
      )
    );
  }
}
