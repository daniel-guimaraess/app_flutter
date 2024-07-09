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

  @override
  Widget build(BuildContext context) {
    alerts = context.watch<AlertRepository>();
    allAlerts = alerts.allAlerts;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Alertas',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      ),
      body: RefreshIndicator(
        onRefresh: () => alerts.checkAlerts(),
        color: Colors.black,
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
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
