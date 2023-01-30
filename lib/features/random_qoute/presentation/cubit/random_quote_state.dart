part of 'random_quote_cubit.dart';

abstract class RandomQuoteState extends Equatable {
  const RandomQuoteState();

  @override
  List<Object> get props => [];
}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteIsLoading extends RandomQuoteState {}

class RandomQuoteLoadedSuccess extends RandomQuoteState {
  final Quote quote;

  const RandomQuoteLoadedSuccess({required this.quote});

  @override
  List<Object> get props => [quote];
}

class RandomQuoteLoadedError extends RandomQuoteState {
  final String msg;

  const RandomQuoteLoadedError({required this.msg});

  @override
  List<Object> get props => [msg];
}
