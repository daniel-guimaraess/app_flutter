import 'package:app/services/gemini_services.dart';
import 'package:flutter/material.dart';

class GeminiAnalyses extends StatefulWidget {
  const GeminiAnalyses({super.key});

  @override
  State<GeminiAnalyses> createState() => _GeminiAnalysesState();
}

class _GeminiAnalysesState extends State<GeminiAnalyses> {
  late Future<String> geminiAnalysis;

  @override
  void initState() {
    super.initState();
    geminiAnalysis = fetchGeminiAnalysis();
  }

  Future<String> fetchGeminiAnalysis() async {
    String analysis = await GeminiService().fetchAnalysis();
    return analysis;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Análise Gemini',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: geminiAnalysis,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff359ac6),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data ?? ''),
                  ],
                ),
              );
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
