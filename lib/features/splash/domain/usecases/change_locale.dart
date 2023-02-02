import 'package:quotes_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/usecases/usecase.dart';
import 'package:quotes_app/features/splash/domain/repositories/lang_repository.dart';

class ChangeLocaleUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLocaleUseCase({required this.langRepository});
  @override
  Future<Either<Failure, bool>> call(String langCode) async {
    return await langRepository.changeLocale(langCode: langCode);
  }
}
