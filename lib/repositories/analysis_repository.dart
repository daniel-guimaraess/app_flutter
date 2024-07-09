import 'package:app/models/analysis.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnalysisRepository extends ChangeNotifier {
  List<Analysis> _allAnalyses = [];
  List<Analysis> get allAnalyses => _allAnalyses;
  String? _token;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _countAnalysesToday = 0;
  int get countAnalysesToday => _countAnalysesToday;

  AnalysisRepository() {
    _getAllAnalses();
    _getCountAnalyses();
  }

  checkAnalyses() async {
    await _getAllAnalses();
    await _getCountAnalyses();
  }

  _getAllAnalses() async {
    String url = 'http://192.168.15.4/api/analyses';
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

  _getCountAnalyses() async {
    String url = 'http://192.168.15.4/api/countanalysestoday';
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
