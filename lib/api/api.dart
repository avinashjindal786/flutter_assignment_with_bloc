import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;
class ApiProvider {
  
  final String _url = 'https://swapi.dev/api/people/';



  Future<UserModel> fetchItems(String? url) async {
    final response = await http.get(Uri.parse(url ?? _url));
    final jsonData = jsonDecode(response.body);

    return UserModel.fromMap(jsonData);
  }
  
  Future<String> fetchSingleItems(String? url) async {
    final response = await http.get(Uri.parse(url ?? _url));
    final jsonData = jsonDecode(response.body);

    return jsonData["next"];
  }

  Future<Widget> fetchFileItems(String url) async {
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(jsonData["title"],textAlign: TextAlign.start,));
  }
}
