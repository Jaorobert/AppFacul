import 'package:flutter/foundation.dart';

class MessageModel {
  final int? idMessage;
  final String? message;
  final int? idUser;
  final int? idCourse;
  final int? semeter;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel(
      {required this.idMessage,
      required this.message,
      required this.idUser,
      required this.idCourse,
      required this.semeter,
      required this.createdAt,
      required this.updatedAt});

  factory MessageModel.fromJson(Map<String, dynamic> message) {
    return MessageModel(
        idMessage: message['id'],
        message: message['message'],
        idUser: message['id_pessoa'],
        idCourse: message['id_curso'],
        semeter: message['semestre'],
        createdAt: DateTime.parse(message['createdAt']),
        updatedAt: DateTime.parse(message['updatedAt']));
  }
}
