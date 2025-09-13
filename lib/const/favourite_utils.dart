import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  final String _favKey = 'fav';
  final String _themeKey = 'theme';

  final SharedPreferences _sharedPreferences =
      GetIt.instance.get<SharedPreferences>();
  bool isFavourite(String code) {
    List<String> favs = getFavourites();
    return favs.contains(code.toUpperCase());
  }

  void saveFavourite(String code) async {
    List<String> existingCodes = getFavourites();

    _sharedPreferences
        .setStringList(_favKey, [...existingCodes, code.toUpperCase()]);
  }

  void removeFavourite(String code) async {
    List<String> existingCodes = getFavourites();
    existingCodes.remove(code.toUpperCase());
    _sharedPreferences.setStringList(_favKey, existingCodes);
  }

  List<String> getFavourites() {
    return _sharedPreferences.getStringList(_favKey) ?? [];
  }

  void clearFavourites() {
    _sharedPreferences.setStringList(_favKey, []);
  }

  void saveTheme(bool isDark) {
    _sharedPreferences.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return _sharedPreferences.getBool(_themeKey) ?? false;
  }
}
