import "package:http/http.dart";
import "dart:convert";

class LoginServices {
  static Future enviarAluno(Object form) async {
    final client = Client();
    try {
      final resp =
          await client.post(Uri.parse('http://192.168.237.64:4000/api/login'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(form));
      return resp;
    } catch (err) {
      print(err);
    }
  }
}
