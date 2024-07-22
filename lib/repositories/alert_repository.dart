import 'dart:convert';
import 'package:app/models/alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AlertRepository extends ChangeNotifier {
  List<Alert> _allAlerts = [];
  List<Alert> get allAlerts => _allAlerts;

  List<Alert> _allAlertsToday = [];
  List<Alert> get allAlertsToday => _allAlertsToday;

  List<Alert> _lastAlerts = [];
  List<Alert> get lastAlerts => _lastAlerts;

  int _countAlertsToday = 0;
  int get countAlertsToday => _countAlertsToday;

  String? _token;
  bool _isLoading = false;

  AlertRepository() {
    _getAllAlerts();
    _getAllAlertsToday();
    _getLastAlerts();
    _getCountAlerts();
  }

  bool get isLoading => _isLoading;

  checkAlerts() async {
    await _getAllAlerts();
    await _getAllAlertsToday();
    await _getLastAlerts();
    await _getCountAlerts();
  }

  _getAllAlerts() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/alerts';
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
        _allAlerts = json.map((alertJson) {
          return Alert(
            id: alertJson['id'],
            type: alertJson['type'],
            petId: alertJson['pet_id'],
            detection: alertJson['detection'],
            confidence: (alertJson['confidence'] as num).toDouble(),
            img: alertJson['img_url'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAlerts = [];
        throw Exception('Failed to load alerts');
      }
    } catch (e) {
      _allAlerts = [];
    } finally {
      _setLoading(false);
    }
  }

  _getAllAlertsToday() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/allalertstoday';
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
        _allAlertsToday = json.map((alertJson) {
          return Alert(
            id: alertJson['id'],
            type: alertJson['type'],
            petId: alertJson['pet_id'],
            detection: alertJson['detection'],
            confidence: (alertJson['confidence'] as num).toDouble(),
            img: alertJson['img_url'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _allAlertsToday = [];
        throw Exception('Failed to load alerts');
      }
    } catch (e) {
      _allAlertsToday = [];
    } finally {
      _setLoading(false);
    }
  }

  _getLastAlerts() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/lastalerts';
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
        _lastAlerts = json.map((alertJson) {
          return Alert(
            id: alertJson['id'],
            type: alertJson['type'],
            petId: alertJson['pet_id'],
            detection: alertJson['detection'],
            confidence: alertJson['confidence'],
            img: alertJson['img_url'],
            date: alertJson['created_at'],
          );
        }).toList();
        notifyListeners();
      } else {
        _lastAlerts = [];
        throw Exception('Failed to load alerts');
      }
    } catch (e) {
      _lastAlerts = [];
    } finally {
      _setLoading(false);
    }
  }

  _getCountAlerts() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/countalertstoday';
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
        _countAlertsToday = json['count'];
        notifyListeners();
      } else {
        _countAlertsToday = 0;
        throw Exception('Failed to load alerts');
      }
    } catch (e) {
      _countAlertsToday = 0;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
