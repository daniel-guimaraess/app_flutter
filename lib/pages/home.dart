import 'package:app/models/alert.dart';
import 'package:app/pages/chart_all_alerts.dart';
import 'package:app/pages/gemini_analyses.dart';
import 'package:app/pages/view_all_alerts_today.dart';
import 'package:app/pages/view_all_analyses_today.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:app/repositories/analyses_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_zoom/widget_zoom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Alert> lastAlerts;
  late AlertRepository alerts;
  int? countAlertsToday;
  late AnalysesRepository analyses;
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

  void viewAllAlertsToday() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewAllAlertsToday()),
    );
  }

  void viewAllAnalysesToday() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ViewAllAnalysesToday()),
    );
  }

  void geminiAnalysesToday() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GeminiAnalyses()),
    );
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
                  child: WidgetZoom(
                    heroAnimationTag: 'tag',
                    zoomWidget: Image.network(
                      alert.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 77, 75, 134),
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final squareSize = screenWidth * 0.35;
    alerts = context.watch<AlertRepository>();
    lastAlerts = alerts.lastAlerts;
    countAlertsToday = alerts.countAlertsToday;
    analyses = context.watch<AnalysesRepository>();
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
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          alerts.checkAlerts();
          analyses.checkAnalyses();
        },
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 77, 75, 134),
                ),
                height: screenHeight * 0.25,
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
                              'Alertas',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff7472b2)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              countAlertsToday?.toString() ?? 'Falha',
                              style: const TextStyle(
                                color: Color(0xff5e5d9f),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        viewAllAlertsToday();
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
                              'Análises',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff7472b2)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              countAnalysesToday?.toString() ?? 'Falha',
                              style: const TextStyle(
                                color: Color(0xff5e5d9f),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        viewAllAnalysesToday();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Dashboard | Alertas Hoje',
                  style: TextStyle(color: Color.fromARGB(255, 52, 51, 92)),
                ),
              ),
              const SizedBox(height: 30),
              const ChartAllAlerts(),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Últimos alertas',
                  style: TextStyle(color: Color.fromARGB(255, 52, 51, 92)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: screenHeight * 0.45,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int alert) {
                    return ListTile(
                      leading: SizedBox(
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(lastAlerts[alert].img),
                        ),
                      ),
                      title: Text(
                        lastAlerts[alert].detection,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 52, 51, 92)),
                      ),
                      trailing: Text(
                        lastAlerts[alert].date,
                        selectionColor: const Color.fromARGB(255, 52, 51, 92),
                      ),
                      onTap: () => {viewAlert(lastAlerts[alert])},
                    );
                  },
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  separatorBuilder: (_, __) => const Divider(
                    height: 5,
                    color: Color(0xffb0afd4),
                  ),
                  itemCount: lastAlerts.length,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
