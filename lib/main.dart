import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home.dart';
import 'pages/chat.dart';

void main() => runApp(MyApp());

final GoRouter _router = GoRouter(

  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MyHomePage(child: Text("Home"),);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'chat',
          builder: (BuildContext context, GoRouterState state) {
            return MyHomePage(child: ChatPage());
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
