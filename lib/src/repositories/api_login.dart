/*import "package:http/http.dart";
import "dart:convert";

class LoginRepository {
  static Future enviarAluno(Object form) async {
    final client = Client();
    try {
      final resp = await client.post(
          Uri.parse('https://app-back-facul.onrender.com/aluno/login'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(form));
      print(jsonEncode(form));
      return resp;
    } catch (err) {
      print(err);
    }
  }
}
*/