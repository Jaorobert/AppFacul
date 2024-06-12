import "package:app_facul/src/data/model/user.dart";
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

      user(authorization) => client.post(
              Uri.parse("https://app-back-facul.onrender.com/api/login"),
              headers: {
                'Context-type': 'application/json; charset=UTF-8',
                'authorization': authorization
              });

      Future<Response> getUser(String authorization) async {
        try {
          final userResponse = await user(authorization);
          return userResponse;
        } catch (error) {
          return throw error;
        }
      }

      if (resp.statusCode == 200) {
        final shared = await SharedPreferences.getInstance();
        final authorization = resp.headers["authorization"]!;

        final Map<String, dynamic> jsonLogin = json.decode(resp.body);
        final Map<String, dynamic> jsonUser;

        final userResponse = getUser(authorization);

        print(userResponse);

        await shared.setString("authorization", authorization);
        await shared.setBool("bo_aluno", jsonLogin['permissions']['bo_aluno']);
        await shared.setBool(
            "bo_professor", jsonLogin['permissions']['bo_professor']);
        await shared.setBool(
            "bo_coordenacao", jsonLogin['permissions']['bo_coordenacao']);
        return {resp, userResponse};
      }
    } catch (err) {
      print(err);
    }
  }
}
