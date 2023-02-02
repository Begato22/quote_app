part of 'locale_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocaleInitial extends LocaleState {
  const LocaleInitial(Locale selectedLocale):super(selectedLocale);
}

class ChangeLocalState extends LocaleState{
  const ChangeLocalState(super.locale);
}
class GetCurrentLangCodeState extends LocaleState{
  const GetCurrentLangCodeState(super.locale);
}
