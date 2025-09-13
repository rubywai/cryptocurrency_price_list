import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/favourite_utils.dart';
import 'app_state_model.dart';

typedef AppStateProvider = NotifierProvider<AppStateNotifier, AppStateModel>;

class AppStateNotifier extends Notifier<AppStateModel> {
  final SharedPrefsUtils _prefsUtils = SharedPrefsUtils();
  @override
  AppStateModel build() {
    bool isDark = _prefsUtils.getTheme();
    return AppStateModel(
      isDark: isDark,
    );
  }

  void changeTheme(bool isDark) {
    _prefsUtils.saveTheme(isDark);
    state = state.copyWith(isDark: isDark);
  }
}
