import 'package:app/pages/splash.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:app/repositories/analytics_repository.dart';
import 'package:app/repositories/monitoring_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  Gemini.init(apiKey: dotenv.env['API_KEY_GEMINI'] ?? '');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlertRepository()),
        ChangeNotifierProvider(create: (context) => AnalyticsRepository()),
        ChangeNotifierProvider(create: (context) => MonitoringRepository()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const SplashPage(),
    );
  }
}
