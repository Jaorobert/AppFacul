import 'dart:io';

import 'package:app_facul/src/data/model/semeters.dart';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Semeter>> getSemeters() async {
  final shared = await SharedPreferences.getInstance();
  final authorization = shared.getString('authorization');
  if (authorization != null) {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.237.68:4000/api/buscarSemestre"),
        headers: {
          "authorization": authorization,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> listSemeters = json.decode(response.body)["semeters"];
        List<Semeter> semeters =
            listSemeters.map((data) => Semeter.fromJson(data)).toList();
        return semeters;
      } else {
        throw Exception('Erro na requisição HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Erro na requisição HTTP');
    }
  } else {
    throw Exception(
        "Token de autorização não encontrado nos SharedPreferences.");
  }
}
