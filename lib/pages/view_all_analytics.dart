import 'package:app/models/analysis.dart';
import 'package:app/pages/view_analysis.dart';
import 'package:app/repositories/analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllAnalytics extends StatefulWidget {
  const ViewAllAnalytics({super.key});

  @override
  State<ViewAllAnalytics> createState() => _ViewAllAnalytics();
}

class _ViewAllAnalytics extends State<ViewAllAnalytics> {
  late List<Analysis> allAnalytics;
  late AnalyticsRepository analytics;

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
    analytics = context.watch<AnalyticsRepository>();
    allAnalytics = analytics.allAnalytics;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todas análises',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 6, 61, 124),
      ),
      body: RefreshIndicator(
        onRefresh: () => analytics.checkAnalytics(),
        color: Colors.black,
        child: Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int analysis) {
                return ListTile(
                  leading: SizedBox(
                    width: 45,
                    height: 40,
                    child: Image.asset('images/icons/google-gemini-icon.png'),
                  ),
                  title: Text(
                    allAnalytics[analysis].date,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () => viewAnalysis(allAnalytics[analysis]),
                );
              },
              separatorBuilder: (_, __) => const Divider(
                    height: 10,
                  ),
              itemCount: allAnalytics.length),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
