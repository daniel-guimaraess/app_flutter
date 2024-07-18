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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 61, 124),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data: ${widget.analysis.date}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Análise: ${widget.analysis.analysis}')
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
