import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  final Gemini gemini = Gemini.instance;
  String? _token;

  Future<String> fetchAnalysis() async {
    String url = 'http://192.168.15.4/api/allalertstoday';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        String prompt = json['prompt'];

        if (prompt.isNotEmpty) {
          try {
            final response = await gemini.text(prompt);
            final resp = response?.output;

            if (resp != null) {
              final res = resp.replaceAll('*', '');

              final responseSave = await http.post(
                Uri.parse('http://192.168.15.4/analyses'),
                body: jsonEncode({'analysis': res}),
                headers: {'Authorization': 'Bearer $_token'},
              );

              if (responseSave.statusCode == 200) {
                return res;
              } else {
                throw Exception('Erro ao salvar análise');
              }
            } else {
              throw Exception('Resposta do Gemini é nula');
            }
          } catch (e) {
            throw Exception('Erro ao buscar análise do Gemini: $e');
          }
        } else {
          throw Exception('Alertas vazios');
        }
      } else {
        throw Exception('Falha ao carregar alertas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição HTTP: $e');
    }
  }
}
