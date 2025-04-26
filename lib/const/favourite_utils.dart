import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteUtils {
  final String _key = 'fav';
  final SharedPreferences _sharedPreferences =
      GetIt.instance.get<SharedPreferences>();
  bool isFavourite(String code) {
    List<String> favs = getFavourites();
    return favs.contains(code.toUpperCase());
  }

  void saveFavourite(String code) async {
    List<String> existingCodes = getFavourites();

    _sharedPreferences
        .setStringList(_key, [...existingCodes, code.toUpperCase()]);
  }

  void removeFavourite(String code) async {
    List<String> existingCodes = getFavourites();
    existingCodes.remove(code.toUpperCase());
    _sharedPreferences.setStringList(_key, existingCodes);
  }

  List<String> getFavourites() {
    return _sharedPreferences.getStringList(_key) ?? [];
  }
}
