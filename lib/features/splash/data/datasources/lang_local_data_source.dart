import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLocale({required String langCode});
  Future<String?> getCurrentLocale();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<bool> changeLocale({required String langCode}) async {
    return await sharedPreferences.setString(AppStrings.locale, langCode);
  }

  @override
  Future<String?> getCurrentLocale() async {
    return sharedPreferences.getString(AppStrings.locale) ??
        AppStrings.englishCode;
  }
}
