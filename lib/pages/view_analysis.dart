import 'package:app/models/analysis.dart';
import 'package:flutter/material.dart';

class ViewAnalysis extends StatefulWidget {
  final Analysis analysis;

  const ViewAnalysis({super.key, required this.analysis});

  @override
  State<ViewAnalysis> createState() => _ViewAnalysisState();
}

class _ViewAnalysisState extends State<ViewAnalysis> {
  @override
  Widget build(BuildContext context) {
    String analysisType = widget.analysis.type == 'standalone'
        ? 'Análise avulsa'
        : 'Análise do dia';

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
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tipo: $analysisType',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Data: ${widget.analysis.date}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(widget.analysis.analysis)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
