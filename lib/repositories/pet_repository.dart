// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class PetRepository extends ChangeNotifier {
//   String? _token;

//   // PetRepository() {
//   //   getStatus();
//   // }

//   // Future<void> getChartData() async {
//   //   String url = '${dotenv.env['BACKEND_URL']}/api/statusmonitoring';
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   _token = prefs.getString('jwt_token');

//   //   final response = await http.get(
//   //     Uri.parse(url),
//   //     headers: {'Authorization': 'Bearer $_token'},
//   //   );

//   //   if (response.statusCode == 200) {
//   //     final Map<String, dynamic> json = jsonDecode(response.body);
//   //     bool status = json['status'];
//   //     _status = status;
//   //   } else {
//   //     _status = false;
//   //   }

//   //   notifyListeners();
//   // }
// }
