import 'package:go_router/go_router.dart';
import 'screens/login.dart';
import 'screens/signup.dart';

abstract class Routes {
  static const login = '/login';
  static const signup = '/signup';
}

final routes = <GoRoute>[
  GoRoute(
    path: Routes.login,
    builder: (ctx, state) => const LoginPage(),
  ),
  GoRoute(
    path: Routes.signup,
    builder: (ctx, state) => const SignupPage(),
  ),
];