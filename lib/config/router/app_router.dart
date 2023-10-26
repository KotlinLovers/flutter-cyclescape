import 'package:cyclescape/config/router/app_router_notifier.dart';
import 'package:cyclescape/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
      initialLocation: '/onboarding',
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
          builder: (context, state) => const MapSample(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
      redirect: (context, state) {
        final isGoingTo = state.fullPath;
        final authStatus = goRouterNotifier.authStatus;

        if (authStatus == AuthStatus.notAunthenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/onboarding') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/onboarding') {
            return '/';
          }
        }
        return null;
      });
});
