import 'package:app/pages/gemini.dart';
import 'package:app/pages/monitoring_page.dart';
import 'package:app/pages/mypets_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/splash.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:app/repositories/analyses_repository.dart';
import 'package:app/repositories/monitoring_repository.dart';
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
        ChangeNotifierProvider(create: (context) => AnalysesRepository()),
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

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    GeminiPage(),
    MonitoringPage(),
    MyPetsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20, // Ajuste o tamanho dos ícones
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Gemini AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam_outlined),
            label: 'Monitoramento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Meus Pets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 52, 51, 92),
        unselectedItemColor:
            Colors.grey, // Adicionando cor para itens não selecionados
        onTap: _onItemTapped,
      ),
      backgroundColor: Colors.white,
    );
  }
}
