import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MonitoringRepository extends ChangeNotifier {
  String? _token;
  bool _status = false;
  bool get status => _status;
  bool _enable = false;
  bool get enable => _enable;
  bool _disable = false;
  bool get disable => _disable;

  MonitoringRepository() {
    getStatus();
  }

  Future<void> getStatus() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/statusmonitoring';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      bool status = json['status'];
      _status = status;
    } else {
      _status = false;
    }

    notifyListeners();
  }

  Future<void> enableMonitoring() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/startmonitoring';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      _enable = true;
    } else {
      _enable = false;
    }

    notifyListeners();
  }

  Future<void> disableMonitoring() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/stopmonitoring';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      _disable = true;
    } else {
      _disable = false;
    }

    notifyListeners();
  }
}
