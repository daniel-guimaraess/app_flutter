import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final Gemini gemini = Gemini.instance;
  String? _token;

  Future<String> fetchAnalysis() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/allalertstodaygemini';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      String prompt = json['prompt'];

      if (prompt.isNotEmpty) {
        final response = await gemini.text(prompt);
        final resp = response?.output;

        if (resp != null) {
          final res = resp.replaceAll('*', '');

          final responseSave = await http.post(
            Uri.parse('${dotenv.env['BACKEND_URL']}/api/analyses'),
            body:
                jsonEncode({'type': 'standalone', 'analysis': res.toString()}),
            headers: {
              'Authorization': 'Bearer $_token',
              'Content-Type': 'application/json',
            },
          );

          if (responseSave.statusCode == 200) {
            return res;
          } else {
            return 'Não foi possível salvar a análise';
          }
        } else {
          return 'Não foi possível retornar a análise';
        }
      } else {
        return 'Não foi possível realizar análise, pois não há alertas hoje';
      }
    } else {
      return 'Não foi possível realizar análise';
    }
  }
}
