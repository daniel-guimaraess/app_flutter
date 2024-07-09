import 'package:app/models/alert.dart';
import 'package:app/pages/view_all_alerts.dart';
import 'package:app/pages/view_all_analyses.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:app/repositories/analysis_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void viewAlert(Alert alert) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          color: const Color.fromARGB(255, 243, 242, 242),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    alert.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Alerta: ${alert.detection}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nível de confiança do alerta: ${alert.confidence}%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Data: ${alert.date}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
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
        title: const Text(
          'Bem vindo, Daniel!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
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
            const SizedBox(height: 20),
            Row(
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
                            fontSize: 16,
                          ),
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
                            fontSize: 16,
                          ),
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
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Últimos alertas',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
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
              padding: const EdgeInsets.only(left: 80, right: 80, bottom: 50),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 253, 94, 147),
                      Color.fromARGB(255, 0, 136, 248),
                    ],
                  ),
                ),
                child: const Text(
                  'ANÁLISE GEMINI AI',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
