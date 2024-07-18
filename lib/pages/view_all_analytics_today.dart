import 'package:app/models/analysis.dart';
import 'package:app/pages/view_all_analytics.dart';
import 'package:app/pages/view_analysis.dart';
import 'package:app/repositories/analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllAnalyticsToday extends StatefulWidget {
  const ViewAllAnalyticsToday({super.key});

  @override
  State<ViewAllAnalyticsToday> createState() => _ViewAllAnalyticsToday();
}

class _ViewAllAnalyticsToday extends State<ViewAllAnalyticsToday> {
  late List<Analysis> allAnalyticsToday;
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
    allAnalyticsToday = analytics.allAnalyticsToday;

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
                    allAnalyticsToday[analysis].date,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () => viewAnalysis(allAnalyticsToday[analysis]),
                );
              },
              separatorBuilder: (_, __) => const Divider(
                    height: 10,
                  ),
              itemCount: allAnalyticsToday.length),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ViewAllAnalytics()),
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
