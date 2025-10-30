import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/TodoDetailsScreen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/todo/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return TodoDetailsScreen(todoId: id);
      },
    ),
  ],
);