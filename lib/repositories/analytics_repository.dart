import 'package:app/models/analysis.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsRepository extends ChangeNotifier {
  List<Analysis> _allAnalytics = [];
  List<Analysis> get allAnalytics => _allAnalytics;

  List<Analysis> _allAnalyticsToday = [];
  List<Analysis> get allAnalyticsToday => _allAnalyticsToday;

  String? _token;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _countAnalyticsToday = 0;
  int get countAnalyticsToday => _countAnalyticsToday;

  AnalyticsRepository() {
    _getAllAnalytics();
    _getAllAnalyticsToday();
    _getCountAnalytics();
  }

  checkAnalytics() async {
    await _getAllAnalytics();
    await _getAllAnalyticsToday();
    await _getCountAnalytics();
  }

  _getAllAnalytics() async {
    String url = 'http://192.168.15.4/api/analytics';
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
        _allAnalytics = json.map((alertJson) {
          return Analysis(
            id: alertJson['id'],
            analysis: alertJson['analysis'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAnalytics = [];
        throw Exception('Failed to load analyses');
      }
    } catch (e) {
      _allAnalytics = [];
    } finally {
      _setLoading(false);
    }
  }

  _getAllAnalyticsToday() async {
    String url = 'http://192.168.15.4/api/analytics';
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
        _allAnalyticsToday = json.map((alertJson) {
          return Analysis(
            id: alertJson['id'],
            analysis: alertJson['analysis'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAnalyticsToday = [];
        throw Exception('Failed to load analytics');
      }
    } catch (e) {
      _allAnalyticsToday = [];
    } finally {
      _setLoading(false);
    }
  }

  _getCountAnalytics() async {
    String url = 'http://192.168.15.4/api/countanalyticstoday';
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
        _countAnalyticsToday = json['count'];
        notifyListeners();
      } else {
        _countAnalyticsToday = 0;
        throw Exception('Failed to load analytics');
      }
    } catch (e) {
      _countAnalyticsToday = 0;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
