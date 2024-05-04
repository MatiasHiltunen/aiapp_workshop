import 'package:aiapp/providers/openai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';
import 'pages/chat.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => OpenAIProvider())
  ],
  child: MyApp(),  
  ));

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
