import 'package:go_router/go_router.dart';
import 'screens/login.dart';

abstract class Routes {
  static const login = '/login';
}

final routes = <GoRoute>[
  GoRoute(path: Routes.login, builder: (ctx, state) => const LoginPage()),
];
