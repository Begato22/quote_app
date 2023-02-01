import 'dart:convert';

import 'package:quotes_app/core/errors/exceptions.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_qoute/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDataSource {
  Future<QuoteModel> getLastQuote();
  Future<void> casheQuote(QuoteModel quoteModel);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomQuoteLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> casheQuote(QuoteModel quoteModel) {
    return sharedPreferences.setString(
      AppStrings.cashedQuote,
      json.encode(quoteModel),
    );
  }

  @override
  Future<QuoteModel> getLastQuote() {
    final jsonString = sharedPreferences.getString(AppStrings.cashedQuote);
    if (jsonString != null) {
      final quote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return quote;
    } else {
      throw CacheException();
    }
  }
}
