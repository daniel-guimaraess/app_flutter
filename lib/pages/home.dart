import 'package:app/models/alert_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<AlertModel> alerts = [];

  void _getAlerts() {
    alerts = AlertModel.getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    _getAlerts();
    // Obter a altura da tela
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bem vindo, Daniel!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 200,
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 200,
                  margin: const EdgeInsets.only(top: 40, left: 10, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Meus alertas',
            ),
          ),
          Container(
            // Definir a altura como 30% da altura da tela
            height: screenHeight * 0.4,
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${alerts[index].message}       ${alerts[index].confiance.toString()}%',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
