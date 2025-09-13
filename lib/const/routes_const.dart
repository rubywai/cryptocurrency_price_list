import 'package:crypto_price_list/pages/favorite_page.dart';
import 'package:crypto_price_list/pages/news_page.dart';
import 'package:crypto_price_list/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/price_detail_page.dart';
import '../pages/price_list_page.dart';

const List<String> mainRoutes = ['/', '/favourites', '/news', '/settings'];

final GoRouter routes = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'list',
              path: '/',
              builder: (context, state) {
                return PriceListPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'favourites',
              path: '/favourites',
              builder: (context, state) {
                return FavoritePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'news',
              path: '/news',
              builder: (context, state) {
                return NewsPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'settings',
              path: '/settings',
              builder: (context, state) {
                return SettingPage();
              },
            ),
          ],
        ),
      ],
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
  ],
);
