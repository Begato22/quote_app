import 'dart:convert';

import 'package:quotes_app/core/api/end_points.dart';
import 'package:quotes_app/core/errors/exceptions.dart';
import 'package:quotes_app/features/random_qoute/data/models/quote_model.dart';

import 'package:http/http.dart' as http;

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRemoteRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  final http.Client client;

  RandomQuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<QuoteModel> getRemoteRandomQuote() async {
    final respose = await client.get(Uri.parse(EndPoints.randomQuote));
    if (respose.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(respose.body));
    } else {
      throw ServerException();
    }
  }
}
