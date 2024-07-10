import 'package:app/models/analysis.dart';
import 'package:app/pages/view_analysis.dart';
import 'package:app/repositories/analysis_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllAnalyses extends StatefulWidget {
  const ViewAllAnalyses({super.key});

  @override
  State<ViewAllAnalyses> createState() => _ViewAllAnalysesState();
}

class _ViewAllAnalysesState extends State<ViewAllAnalyses> {
  late List<Analysis> allAnalyses;
  late AnalysisRepository analyses;

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
    analyses = context.watch<AnalysisRepository>();
    allAnalyses = analyses.allAnalyses;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Análises',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      ),
      body: RefreshIndicator(
        onRefresh: () => analyses.checkAnalyses(),
        color: Colors.black,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int analysis) {
              return ListTile(
                leading: SizedBox(
                  width: 45,
                  height: 40,
                  child: Image.asset('images/icons/google-gemini-icon.png'),
                ),
                title: Text(
                  allAnalyses[analysis].date,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () => viewAnalysis(allAnalyses[analysis]),
              );
            },
            separatorBuilder: (_, __) => const Divider(
                  height: 10,
                ),
            itemCount: allAnalyses.length),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
