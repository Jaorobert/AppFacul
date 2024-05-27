import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Semeter {
  final String? ds_curso;
  final String? ds_semeter;
  final int? id_aluno;
  Semeter(this.ds_semeter, this.ds_curso, this.id_aluno);

  factory Semeter.fromJson(Map<String, dynamic> json) {
    return Semeter(
      json['ds_semeter'],
      json['ds_curso'],
      json['id_aluno'],
    );
  }
}

Future<List<Semeter>> getSemeters() async {
  final shared = await SharedPreferences.getInstance();
  final authorization = shared.getString('authorization');

  if (authorization != null) {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.237.64:4000/api/aluno/buscarSemestre"),
        headers: {"authorization": authorization},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Semeter> semeters =
            jsonResponse.map((data) => Semeter.fromJson(data)).toList();
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
