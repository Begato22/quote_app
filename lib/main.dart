import 'package:flutter/material.dart';
import 'package:quotes_app/app.dart';
import 'package:quotes_app/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const QuoteApp());
}
