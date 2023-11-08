import 'package:cyclescape/config/router/app_router_notifier.dart';
import 'package:cyclescape/presentation/providers/auth_provider.dart';
import 'package:cyclescape/presentation/screens/bicycle_map_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: '/loading',
      refreshListenable: goRouterNotifier,
      routes: [
        ///* Auth Routes
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),

        ///* Product Routes
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: '/map',
          builder: (context, state) => const MapScreen(),
        ),

        GoRoute(
            path: '/map/bicycle/:latitude/:longitude',
            builder: (context, state) {
              final latitudeString = state.pathParameters['latitude']!;
              final latitude = double.tryParse(latitudeString);
              final longitudeString = state.pathParameters['longitude']!;
              final longitude = double.tryParse(longitudeString);

              if (latitude != null) {
                return BicycleMapScreen(
                  data: {
                    'latitude': latitude,
                    'longitude': longitude,
                  },
                );
              } else {
                throw Exception('Invalid bicycle latitude/longitude.');
              }
            }),

        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),

        GoRoute(
          path: '/profile-edit',
          builder: (context, state) => const UpgradeProfileScreen(),
        ),

        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnBoardingScreen(),
        ),

        GoRoute(
          path: '/loading',
          builder: (context, state) => const LoadingScreen(),
        ),

        GoRoute(
          path: '/bicycle/:id',
          builder: (context, state) {
            final idString = state.pathParameters['id']!;
            final id = int.tryParse(idString);
            if (id != null) {
              return BicycleDetailScreen(id: id);
            } else {
              throw Exception('Invalid bicycle ID.');
            }
          },
        ),
      ],
      redirect: (context, state) {
        final isGoingTo = state.fullPath;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoingTo == '/loading' && authStatus == AuthStatus.checking) {
          return '/onboarding';
        }

        if (authStatus == AuthStatus.notAunthenticated) {
          if (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/onboarding' ||
              isGoingTo == '/loading') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/onboarding' ||
              isGoingTo == '/loading') {
            return '/';
          }
        }
        return null;
      });
});
