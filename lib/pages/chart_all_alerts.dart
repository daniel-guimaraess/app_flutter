import 'package:app/repositories/alert_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartAllAlerts extends StatefulWidget {
  const ChartAllAlerts({super.key});

  @override
  State<StatefulWidget> createState() => ChartAllAlertsState();
}

class ChartAllAlertsState extends State<ChartAllAlerts> {
  int touchedIndex = -1;
  late AlertRepository alerts;
  Map<String, dynamic> chartData = {};

  @override
  Widget build(BuildContext context) {
    alerts = context.watch<AlertRepository>();
    chartData = alerts.chartData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.3,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffaeaed2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Tinha',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  InkWell(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 108, 107, 156),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Lua',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () => {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final List<PieChartSectionData> sections = [];
    if (chartData.isNotEmpty) {
      if (chartData['Tinha']['percentage'] == 0 &&
          chartData['Tinha']['percentage'] == 0) {
        sections.add(
          PieChartSectionData(
            color: const Color(0xffaeaed2),
            value: 50,
            title: 'Nenhum alerta',
            radius: touchedIndex == 0 ? 110.0 : 100.0,
            titleStyle: TextStyle(
              fontSize: touchedIndex == 0 ? 20.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                )
              ],
            ),
          ),
        );
        sections.add(
          PieChartSectionData(
            color: const Color.fromARGB(255, 108, 107, 156),
            value: 50,
            title: 'Nenhum alerta',
            radius: touchedIndex == 1 ? 110.0 : 100.0,
            titleStyle: TextStyle(
              fontSize: touchedIndex == 1 ? 20.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                )
              ],
            ),
          ),
        );
      }
      if (chartData.containsKey('Tinha')) {
        final sectionData = chartData['Tinha'];
        final double percentage = (sectionData['percentage'] as num).toDouble();

        sections.add(
          PieChartSectionData(
            color: const Color(0xffaeaed2),
            value: percentage,
            title: '${percentage.toStringAsFixed(0)}%',
            radius: touchedIndex == 0 ? 110.0 : 100.0,
            titleStyle: TextStyle(
              fontSize: touchedIndex == 0 ? 20.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                )
              ],
            ),
          ),
        );
      }

      if (chartData.containsKey('Lua')) {
        final sectionData = chartData['Lua'];
        final double percentage = (sectionData['percentage'] as num).toDouble();
        sections.add(
          PieChartSectionData(
            color: const Color.fromARGB(255, 108, 107, 156),
            value: percentage,
            title: '${percentage.toStringAsFixed(0)}%',
            radius: touchedIndex == 1 ? 110.0 : 100.0,
            titleStyle: TextStyle(
              fontSize: touchedIndex == 1 ? 20.0 : 16.0,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                )
              ],
            ),
          ),
        );
      }
    }

    return sections;
  }
}
