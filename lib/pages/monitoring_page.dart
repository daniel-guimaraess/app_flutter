import 'package:app/repositories/monitoring_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => MonitoringPageState();
}

class MonitoringPageState extends State<MonitoringPage> {
  @override
  void initState() {
    super.initState();
    // Inicializar status ao iniciar a página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStatus();
    });
  }

  Future<void> _loadStatus() async {
    final monitoringRepo = context.read<MonitoringRepository>();
    await monitoringRepo.getStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final monitoringRepo = context.watch<MonitoringRepository>();
    final status = monitoringRepo.status;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitoramento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 260,
            width: double.infinity,
            color: Colors.black,
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Switch(
                value: status,
                onChanged: (value) async {
                  if (value) {
                    await monitoringRepo.enableMonitoring();
                  } else {
                    await monitoringRepo.disableMonitoring();
                  }
                  // Atualiza o status após a mudança
                  await monitoringRepo.getStatus();
                  // Atualiza a interface após a mudança
                  setState(() {});
                },
                activeColor: const Color(0xff359ac6),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(width: 10),
              Text(
                status == true
                    ? 'Monitoramento habilitado'
                    : 'Monitoramento desabilitado',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
