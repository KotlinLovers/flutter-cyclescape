import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
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
    GoRoute(
      path: '/map',
      builder: (context, state) => const MapSample(),
    ),

    ///* Product Routes
    //GoRoute(
    //  path: '/',
    //  builder: (context, state) => const ProductsScreen(),
    //),
  ],
);
