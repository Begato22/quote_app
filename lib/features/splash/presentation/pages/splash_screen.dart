import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quotes_app/config/routes/app_routes.dart';
import 'package:quotes_app/core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  void _getStated() {
    Navigator.pushReplacementNamed(context, Routes.randomQuoteRote);
  }

  void _startDelay() {
    _timer = Timer(const Duration(milliseconds: 2000), () {
      _getStated();
    });
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImages.quote),
      ),
    );
  }
}
