import 'package:crypto_price_list/const/routes_const.dart';
import 'package:crypto_price_list/pages/favorite_page.dart';
import 'package:crypto_price_list/pages/news_page.dart';
import 'package:crypto_price_list/pages/price_list_page.dart';
import 'package:crypto_price_list/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    GoRouterState state = GoRouter.of(context).state;
    String path = state.uri.path;
    return Scaffold(
      body: Column(
        children: [
          if (width >= 600)
            DefaultTabController(
              length: 4,
              initialIndex: mainRoutes.indexOf(path),
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.home),
                        text: 'Home',
                      ),
                      Tab(
                        icon: Icon(Icons.star),
                        text: 'Favourite',
                      ),
                      Tab(
                        icon: Icon(Icons.newspaper),
                        text: 'News',
                      ),
                      Tab(
                        icon: Icon(Icons.settings),
                        text: 'Settings',
                      ),
                    ],
                    onTap: (index) {
                      context.go(mainRoutes[index]);
                    },
                  ),
                ],
              ),
            ),
          if (path == '/') Expanded(child: PriceListPage()),
          if (path == '/favourites') FavoritePage(),
          if (path == '/news') NewsPage(),
          if (path == '/settings') SettingPage(),
        ],
      ),
      bottomNavigationBar: width < 600
          ? NavigationBar(
              selectedIndex: mainRoutes.indexOf(path),
              onDestinationSelected: (index) {
                context.go(mainRoutes[index]);
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.star),
                  label: 'Favourite',
                ),
                NavigationDestination(
                  icon: Icon(Icons.newspaper),
                  label: 'News',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
          : null,
    );
  }
}
