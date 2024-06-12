// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'dart:ffi';

class Permissions {
  bool _bo_professor = false;
  bool _bo_aluno = false;
  bool _bo_coordenacao = false;

  set isStudent(bool permission) {
    _bo_aluno = permission;
  }

  set isTeacher(bool permission) {
    _bo_professor = permission;
  }

  set isCoordination(bool permision) {
    _bo_coordenacao = permision;
  }

  get permissionUser {
    if (_bo_aluno) return _bo_aluno;
    if (_bo_coordenacao) return _bo_coordenacao;
    if (_bo_professor) return _bo_professor;
    return null;
  }
}
