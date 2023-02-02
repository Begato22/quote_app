import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_app/features/random_qoute/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes_app/features/random_qoute/presentation/screens/quote_screen.dart';
import 'package:quotes_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:quotes_app/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRote = '/randomQuote';
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.randomQuoteRote:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RandomQuoteCubit>(
            create: (context) => di.sl<RandomQuoteCubit>(),
            child: const QuoteScreen(),
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            'undefined Page :{',
          ),
        ),
      ),
    );
  }
}
