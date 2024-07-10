import 'package:app/models/alert.dart';
import 'package:app/pages/gemini_analyses.dart';
import 'package:app/pages/view_all_alerts.dart';
import 'package:app/pages/view_all_analyses.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:app/repositories/analysis_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Alert> lastAlerts;
  late AlertRepository alerts;
  int? countAlertsToday;
  late AnalysisRepository analyses;
  int? countAnalysesToday;
  String? userName;

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
    });
  }

  void viewAlert(Alert alert) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          color: const Color.fromARGB(255, 243, 242, 242),
          height: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    alert.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff359ac6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Descrição: ${alert.detection}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nível de confiança da detecção: ${alert.confidence}%',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Data: ${alert.date}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  viewAllAlerts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewAllAlerts()),
    );
  }

  viewAllAnalyses() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewAllAnalyses()),
    );
  }

  geminiAnalysesToday() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GeminiAnalyses()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth * 0.4;
    alerts = context.watch<AlertRepository>();
    lastAlerts = alerts.lastAlerts;
    countAlertsToday = alerts.countAlertsToday;
    analyses = context.watch<AnalysisRepository>();
    countAnalysesToday = analyses.countAnalysesToday;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bem vindo, ${userName ?? ''}!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xff359ac6),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          alerts.checkAlerts();
          analyses.checkAnalyses();
          return Future.value();
        },
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xff359ac6),
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: squareSize,
                      height: squareSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Alertas hoje',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 61, 61, 61)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            countAlertsToday?.toString() ?? 'Falha',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      viewAllAlerts();
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: squareSize,
                      height: squareSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Análises hoje',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 61, 61, 61)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            countAnalysesToday?.toString() ?? 'Falha',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      viewAllAnalyses();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int alert) {
                  return ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: Image.network(lastAlerts[alert].img),
                    ),
                    title: Text(
                      lastAlerts[alert].detection,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Text(lastAlerts[alert].date),
                    onTap: () => viewAlert(lastAlerts[alert]),
                  );
                },
                padding: const EdgeInsets.only(left: 15, right: 15),
                separatorBuilder: (_, __) => const Divider(
                  height: 5,
                ),
                itemCount: lastAlerts.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90, right: 90, bottom: 20),
              child: GestureDetector(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_outlined,
                          color: Color.fromARGB(255, 180, 39, 29),
                        ),
                        Text('  Monitoramento',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 61, 61, 61))),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, bottom: 15),
              child: GestureDetector(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 250, 0, 83),
                          Color.fromARGB(255, 0, 89, 255),
                        ],
                      ),
                    ),
                    child: const Text(
                      'Análise Gemini AI',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  geminiAnalysesToday();
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
