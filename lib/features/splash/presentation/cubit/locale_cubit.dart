import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/core/utils/app_strings.dart';
import 'package:quotes_app/features/splash/domain/usecases/change_locale.dart';
import 'package:quotes_app/features/splash/domain/usecases/get_saved_locale.dart';

part 'locale_state.dart';

class SplashCubit extends Cubit<LocaleState> {
  final GetSavedLocaleUseCase getSavedLocaleUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;
  SplashCubit(
      {required this.getSavedLocaleUseCase, required this.changeLocaleUseCase})
      : super(const LocaleInitial(Locale(AppStrings.englishCode)));
  String currentLangCode = AppStrings.englishCode;
  Future<void> getLocale() async {
    final response = await getSavedLocaleUseCase.call(NoParams());
    response.fold((failure) {
      debugPrint(AppStrings.casheFailure);
    }, (langCode) {
      currentLangCode = langCode;
      emit(GetCurrentLangCodeState(Locale(langCode)));
    });
  }

  Future<void> _changeLocale(String langCode) async {
    final response = await changeLocaleUseCase.call(langCode);
    response.fold((failure) {
      debugPrint(AppStrings.casheFailure);
    }, (isChanged) {
      currentLangCode = langCode;
      emit(ChangeLocalState(Locale(langCode)));
    });
  }

  void toEnglish() => _changeLocale(AppStrings.englishCode);
  void toArabic() => _changeLocale(AppStrings.arabicCode);
}
