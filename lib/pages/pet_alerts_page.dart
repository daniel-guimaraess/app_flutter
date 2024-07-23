import 'package:flutter/material.dart';

class PetAlertsPage extends StatefulWidget {
  const PetAlertsPage({super.key});

  @override
  State<PetAlertsPage> createState() => PetAlertsPageState();
}

class PetAlertsPageState extends State<PetAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alertas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: Container(),
      backgroundColor: Colors.white,
    );
  }
}
