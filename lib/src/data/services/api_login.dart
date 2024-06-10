import "package:http/http.dart";
import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";

class LoginServices {
  static Future enviarAluno(Object form) async {
    final client = Client();
    try {
      final resp = await client.post(
          Uri.parse('https://app-back-facul.onrender.com/api/login'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(form));

      if (resp.statusCode == 200) {
        final shared = await SharedPreferences.getInstance();
        final authorization = resp.headers["authorization"]!;
        await shared.setString("authorization", authorization);
        return resp;
      }
    } catch (err) {
      print(err);
    }
  }
}
