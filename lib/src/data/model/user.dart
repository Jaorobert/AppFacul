// ignore_for_file: unnecessary_getters_setters, non_constant_identifier_names

import 'package:app_facul/src/data/model/permissions.dart';

class User {
  int id = 0;
  String _name = '';
  String _email = '';
  String _ra = '';
  String _semestre = '';
  String _ds_curso = '';
  Permissions permissions = Permissions();

  String get name {
    return _name;
  }

  String get email {
    return _email;
  }

  String get ra {
    return _ra;
  }

  String get semestre {
    return _semestre;
  }

  String get dsCurso {
    return _ds_curso;
  }

  set name(String name) {
    _name = name;
  }

  set email(String email) {
    _email = email;
  }

  set ra(String ra) {
    _ra = ra;
  }

  set semestre(String semestre) {
    _semestre = semestre;
  }

  set dsCurso(String dsCurso) {
    _ds_curso = dsCurso;
  }
}
