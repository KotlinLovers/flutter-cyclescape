import 'package:cyclescape/presentation/screens/screens.dart';
import 'package:cyclescape/presentation/widgets/widgets.dart';
import 'package:cyclescape/shared/util/shared_entities/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../shared/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? currentPosition;

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) => {currentPosition = position})
          .catchError((e) {
        debugPrint(e);
      });
      setUserPosition(currentPosition!.latitude, currentPosition!.longitude);
      // Location permissions are granted, proceed with creating the map.
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_rounded)),
            IconButton(
                onPressed: () {
                  context.go('/shopping-cart');
                },
                icon: const Icon(Icons.shopping_cart)),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AdvertisementCards(),
            ),
            const BicyclesScreen(),
          ],
        ));
  }
}
