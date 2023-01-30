import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/errors/failures.dart';
import 'package:quotes_app/features/random_qoute/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}