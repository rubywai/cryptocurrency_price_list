import 'package:crypto_price_list/notifiers/price_detail/price_detail_notifier.dart';
import 'package:crypto_price_list/notifiers/price_list/price_list_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../notifiers/app_state/app_state_notifier.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});
  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  final AppStateProvider _stateProvider = GetIt.I.get<AppStateProvider>();
  final PriceDetailProvider _detailProvider =
      GetIt.I.get<PriceDetailProvider>();
  final PriceListProvider _listProvider = GetIt.I.get<PriceListProvider>();
  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(_stateProvider).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Column(
        children: [
          Card(
            child: SwitchListTile(
              title: Text('Dark Theme'),
              value: isDark,
              onChanged: (isDark) {
                ref.read(_stateProvider.notifier).changeTheme(isDark);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Clear Favourites'),
              leading: Icon(Icons.delete),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Clear Favourite List"),
                      content: Text("Are you sure to clear favourite list?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                        FilledButton(
                          onPressed: () {
                            ref.read(_detailProvider.notifier).clearFavourite();
                            ref
                                .read(_listProvider.notifier)
                                .getFavouritesList();
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
