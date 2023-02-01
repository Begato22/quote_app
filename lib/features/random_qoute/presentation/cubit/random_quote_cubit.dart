import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/errors/failures.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/random_qoute/domain/entities/quote.dart';
import 'package:quotes_app/features/random_qoute/domain/usecases/get_random_quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    Either<Failure, Quote> response =
        await getRandomQuoteUseCase.call(NoParams());

    emit(
      response.fold(
          (failure) => RandomQuoteLoadedError(msg: _mapFailureToMsg(failure)),
          (quote) => RandomQuoteLoadedSuccess(quote: quote)),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CashFailure:
        return AppStrings.casheFailure;
      default:
        return AppStrings.unexpectedFailure;
    }
  }
}
