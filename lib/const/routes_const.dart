import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/price_detail_page.dart';
import '../pages/price_list_page.dart';

const List<String> mainRoutes = ['/', '/favourites', '/news', '/settings'];

final GoRouter routes = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      name: 'list',
      path: '/list',
      builder: (context, state) {
        return PriceListPage();
      },
    ),
    GoRoute(
        name: 'detail',
        path: '/detail',
        builder: (context, state) {
          String? symbol = state.uri.queryParameters['symbol'];
          String? name = state.uri.queryParameters['name'];
          if (symbol != null && name != null) {
            return PriceDetailPage(symbol: symbol, name: name);
          }
          return SizedBox.shrink();
        }),
    GoRoute(
      name: 'favourites',
      path: '/favourites',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      name: 'news',
      path: '/news',
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) {
        return HomePage();
      },
    ),
  ],
);
