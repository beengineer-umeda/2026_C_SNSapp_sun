import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

void main() async {
  runApp(const BeEnShotApp());
}

class BeEnShotApp extends StatelessWidget {
  const BeEnShotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BeEn Shot',
      routerConfig: GoRouter(routes: routes, initialLocation: Routes.login),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(83, 226, 103, 1),
          brightness: Brightness.light,
        ),
      ),
    );
  }
}