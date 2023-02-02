import 'package:quotes_app/core/errors/exceptions.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/features/random_qoute/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes_app/features/random_qoute/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes_app/features/random_qoute/domain/entities/quote.dart';
import 'package:quotes_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/features/random_qoute/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;

  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteLocalDataSource,
    required this.randomQuoteRemoteDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomQuote =
            await randomQuoteRemoteDataSource.getRemoteRandomQuote();
        randomQuoteLocalDataSource.casheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRandomQuote =
            await randomQuoteLocalDataSource.getLastQuote();
        return Right(localRandomQuote);
      } on CasheException {
        return Left(CashFailure());
      }
    }
  }
}
