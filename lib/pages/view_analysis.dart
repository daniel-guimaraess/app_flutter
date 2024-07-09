import "package:app/models/analysis.dart";
import "package:flutter/material.dart";

class ViewAnalysis extends StatefulWidget {
  final Analysis analysis;

  const ViewAnalysis({super.key, required this.analysis});

  @override
  State<ViewAnalysis> createState() => _ViewAnalysisState();
}

class _ViewAnalysisState extends State<ViewAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes da análise',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              height: 250,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
