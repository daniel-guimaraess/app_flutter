import 'package:app/models/analysis.dart';
import 'package:app/pages/view_all_analyses.dart';
import 'package:app/pages/view_analysis.dart';
import 'package:app/repositories/analyses_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllAnalysesToday extends StatefulWidget {
  const ViewAllAnalysesToday({super.key});

  @override
  State<ViewAllAnalysesToday> createState() => _ViewAllAnalysesToday();
}

class _ViewAllAnalysesToday extends State<ViewAllAnalysesToday> {
  late List<Analysis> allAnalysesToday;
  late AnalysesRepository analyses;

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
    analyses = context.watch<AnalysesRepository>();
    allAnalysesToday = analyses.allAnalysesToday;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Análises hoje',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 61, 124),
      ),
      body: RefreshIndicator(
        onRefresh: () => analyses.checkAnalyses(),
        color: Colors.black,
        child: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var analysis = allAnalysesToday[index];
              String typeAnalysis = analysis.type == 'standalone'
                  ? 'Análise avulsa'
                  : 'Análise do dia';

              return ListTile(
                leading: SizedBox(
                  width: 45,
                  height: 40,
                  child: Image.asset('images/icons/google-gemini-icon.png'),
                ),
                title: Text(
                  typeAnalysis,
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Text(analysis.date),
                onTap: () => viewAnalysis(analysis),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 10,
            ),
            itemCount: allAnalysesToday.length,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ViewAllAnalyses()),
          );
        },
        label: const Text(
          'Ver todas análises',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 61, 124),
      ),
    );
  }
}
