import 'package:quotes_app/core/api/api_consumer.dart';
import 'package:quotes_app/core/api/end_points.dart';
import 'package:quotes_app/core/errors/exceptions.dart';
import 'package:quotes_app/features/random_qoute/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRemoteRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  final ApiCosumer apiCosumer;

  RandomQuoteRemoteDataSourceImpl({required this.apiCosumer});

  @override
  Future<QuoteModel> getRemoteRandomQuote() async {
    final respose = await apiCosumer.get(EndPoints.randomQuote);
    if (respose.statusCode == 200) {
      return QuoteModel.fromJson(respose);
    } else {
      throw const ServerException();
    }
  }
}
