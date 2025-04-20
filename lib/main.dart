import 'package:crypto_price_list/const/routes_const.dart';
import 'package:crypto_price_list/pages/home_page.dart';
import 'package:crypto_price_list/pages/price_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'pages/price_list_page.dart';

void main() {
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    );
  }
}
