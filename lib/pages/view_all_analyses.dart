import 'package:app/models/analysis.dart';
import 'package:app/pages/view_analysis.dart';
import 'package:app/repositories/analysis_repository.dart';
import 'package:flutter/material.dart';

class ViewAllAnalyses extends StatefulWidget {
  const ViewAllAnalyses({super.key});

  @override
  State<ViewAllAnalyses> createState() => _ViewAllAnalysesState();
}

class _ViewAllAnalysesState extends State<ViewAllAnalyses> {
  viewAnalysis(Analysis analysis) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewAnalysis(
          analysis: analysis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final table = AnalysisRepository.table;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Análises',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int analysis) {
            return ListTile(
              leading: SizedBox(
                width: 45,
                height: 40,
                child: Image.asset('images/icons/google-gemini-icon.png'),
              ),
              title: Text(
                table[analysis].analysis,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(table[analysis].date),
              onTap: () => viewAnalysis(table[analysis]),
            );
          },
          separatorBuilder: (_, __) => const Divider(
                height: 10,
              ),
          itemCount: 5),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
