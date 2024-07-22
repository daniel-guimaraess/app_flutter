import 'package:app/models/analysis.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AnalysesRepository extends ChangeNotifier {
  List<Analysis> _allAnalyses = [];
  List<Analysis> get allAnalyses => _allAnalyses;

  List<Analysis> _allAnalysesToday = [];
  List<Analysis> get allAnalysesToday => _allAnalysesToday;

  String? _token;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _countAnalysesToday = 0;
  int get countAnalysesToday => _countAnalysesToday;

  AnalysesRepository() {
    _getAllAnalyses();
    _getAllAnalysesToday();
    _getCountAnalyses();
  }

  checkAnalyses() async {
    await _getAllAnalyses();
    await _getAllAnalysesToday();
    await _getCountAnalyses();
  }

  _getAllAnalyses() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/analyses';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    _setLoading(true);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _allAnalyses = json.map((alertJson) {
          return Analysis(
            id: alertJson['id'],
            type: alertJson['type'],
            analysis: alertJson['analysis'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAnalyses = [];
        throw Exception('Failed to load analyses');
      }
    } catch (e) {
      _allAnalyses = [];
    } finally {
      _setLoading(false);
    }
  }

  _getAllAnalysesToday() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/allanalysestoday';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    _setLoading(true);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _allAnalysesToday = json.map((alertJson) {
          return Analysis(
            id: alertJson['id'],
            type: alertJson['type'],
            analysis: alertJson['analysis'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAnalysesToday = [];
        throw Exception('Failed to load analyses');
      }
    } catch (e) {
      _allAnalysesToday = [];
    } finally {
      _setLoading(false);
    }
  }

  _getCountAnalyses() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/countanalysestoday';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    _setLoading(true);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        _countAnalysesToday = json['count'];
        notifyListeners();
      } else {
        _countAnalysesToday = 0;
        throw Exception('Failed to load analyses');
      }
    } catch (e) {
      _countAnalysesToday = 0;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
