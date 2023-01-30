import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes_app/config/routes/app_routes.dart';
import 'package:quotes_app/config/themes/app_themes.dart';
import 'package:quotes_app/core/utils/app_strings.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.appTitle,
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      },
      // child: QuoteScreen(),
    );
  }
}
