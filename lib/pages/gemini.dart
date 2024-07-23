import 'package:app/pages/gemini_analyses.dart';
import 'package:flutter/material.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  State<GeminiPage> createState() => GeminiPageState();
}

class GeminiPageState extends State<GeminiPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gemini AI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 75, 134),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centraliza horizontalmente
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            width: screenWidth * 0.95,
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: const Color(0xff8887c0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Conheça o Gemini AI!\nCom nossa ferramenta\nde análise baseada em IA,\nvocê poderá realizar análises\ncompletas e bem estruturadas\nsobre o dia a dia do seu pet.\nReceba informações valiosas\ne dicas de saúde e bem-estar\npara garantir a melhor\nqualidade de vida para\nseu amigo de quatro patas.',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'images/icons/google-gemini-icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              width: screenWidth * 0.6,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 77, 75, 134)),
              child: const Text(
                'Análise Gemini AI',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GeminiAnalyses()),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
