import 'package:app/models/alert.dart';
import 'package:app/repositories/alert_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllAlerts extends StatefulWidget {
  const ViewAllAlerts({super.key});

  @override
  State<ViewAllAlerts> createState() => _ViewAllAlertsState();
}

class _ViewAllAlertsState extends State<ViewAllAlerts> {
  late List<Alert> allAlerts;
  late AlertRepository alerts;

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

  @override
  Widget build(BuildContext context) {
    alerts = context.watch<AlertRepository>();
    allAlerts = alerts.allAlerts;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Alertas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xff359ac6),
      ),
      body: RefreshIndicator(
        onRefresh: () => alerts.checkAlerts(),
        color: Colors.black,
        child: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int alert) {
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.network(allAlerts[alert].img),
                  ),
                  title: Text(
                    allAlerts[alert].detection,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(allAlerts[alert].date),
                  onTap: () => viewAlert(allAlerts[alert]),
                );
              },
              separatorBuilder: (_, __) => const Divider(
                    height: 10,
                  ),
              itemCount: allAlerts.length),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
