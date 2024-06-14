import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Message {
  final int? idMessage;
  final String? message;
  final int? idUser;
  final int? idCourse;
  final int? semeter;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  Message(
      {required this.idMessage,
      required this.message,
      required this.idUser,
      required this.idCourse,
      required this.semeter,
      required this.createdAt,
      required this.updatedAt,
      required this.name});

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
        idMessage: message['id'],
        message: message['message'],
        idUser: message['id_pessoa'],
        idCourse: message['id_curso'],
        semeter: message['semestre'],
        createdAt: DateTime.parse(message['createdAt']).toLocal(),
        updatedAt: DateTime.parse(message['updatedAt']).toLocal(),
        name: message['nome']);
  }
}
