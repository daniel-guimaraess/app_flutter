import 'dart:convert';
import 'package:app/models/pet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PetRepository extends ChangeNotifier {
  List<Pet> _allPets = [];
  List<Pet> get allPets => _allPets;
  bool get isLoading => _isLoading;
  String? _token;
  bool _isLoading = false;

  PetRepository() {
    _getAllPets();
  }

  checkPets() async {
    await _getAllPets();
  }

  _getAllPets() async {
    String url = '${dotenv.env['BACKEND_URL']}/api/pets';
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

        _allPets = json.map((petJson) {
          return Pet(
            id: petJson['id'],
            type: petJson['type'],
            name: petJson['name'],
            dateBirth: petJson['date_birth'],
            race: petJson['race'],
            weight: (petJson['weight'] as num).toDouble(),
            imgUrl: petJson['img_url'],
          );
        }).toList();

        notifyListeners();
      } else {
        _allPets = [];
        throw Exception('Failed to load pets');
      }
    } catch (e) {
      _allPets = [];
      notifyListeners();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
