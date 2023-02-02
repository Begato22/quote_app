import 'package:dartz/dartz.dart';
import 'package:quotes_app/core/errors/failures.dart';

abstract class LangRepository{
  Future<Either<Failure,bool>> changeLocale({required String langCode});
  Future<Either<Failure,String>> getCurrentLocale();
}