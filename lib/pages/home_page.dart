import 'package:crypto_price_list/const/routes_const.dart';
import 'package:crypto_price_list/notifiers/price_detail/price_detail_notifier.dart';
import 'package:crypto_price_list/pages/favorite_page.dart';
import 'package:crypto_price_list/pages/news_page.dart';
import 'package:crypto_price_list/pages/price_list_page.dart';
import 'package:crypto_price_list/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../notifiers/price_list/price_list_state_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.shell,
  });
  final StatefulNavigationShell shell;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final priceListProvider = PriceListProvider(
    () => PriceListStateNotifier(),
  );
  final priceDetailProvider = PriceDetailProvider(
    () => PriceDetailNotifier(),
  );
  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<PriceListProvider>()) {
      GetIt.I.registerSingleton<PriceListProvider>(priceListProvider);
    }
    if (!GetIt.I.isRegistered<PriceDetailProvider>()) {
      GetIt.I.registerSingleton<PriceDetailProvider>(priceDetailProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    StatefulNavigationShell shell = widget.shell;
    return Scaffold(
      body: Column(
        children: [
          if (width >= 600)
            DefaultTabController(
              length: 4,
              initialIndex: shell.currentIndex,
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
                      shell.goBranch(index);
                    },
                  ),
                ],
              ),
            ),
          Expanded(child: shell),
        ],
      ),
      bottomNavigationBar: width < 600
          ? NavigationBar(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: (index) {
                shell.goBranch(index);
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
