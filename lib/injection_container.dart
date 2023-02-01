import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes_app/core/api/api_consumer.dart';
import 'package:quotes_app/core/api/app_intercepters.dart';
import 'package:quotes_app/core/api/dio_consumer.dart';
import 'package:quotes_app/core/network/network_info.dart';
import 'package:quotes_app/features/random_qoute/data/datasources/random_quote_local_data_source.dart';
import 'package:quotes_app/features/random_qoute/data/datasources/random_quote_remote_data_source.dart';
import 'package:quotes_app/features/random_qoute/data/repositories/quote_repository_impl.dart';
import 'package:quotes_app/features/random_qoute/domain/repositories/quote_repository.dart';
import 'package:quotes_app/features/random_qoute/domain/usecases/get_random_quote.dart';
import 'package:quotes_app/features/random_qoute/presentation/cubit/random_quote_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Featchers
  //Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

  //Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));

  //Repositories
  sl.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteLocalDataSource: sl(),
      randomQuoteRemoteDataSource: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiCosumer: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<ApiCosumer>(() => DioConsumer(client: sl()));

  //External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
