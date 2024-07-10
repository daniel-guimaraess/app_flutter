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
    try {
      String analysis = await GeminiService().fetchAnalysis();
      return analysis;
    } catch (e) {
      throw Exception('Erro ao buscar análise do Gemini');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Análise Gemini',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: geminiAnalysis,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao carregar análise'),
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
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
    );
  }
}
