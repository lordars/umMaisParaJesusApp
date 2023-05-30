import 'dart:convert';
import 'package:http/http.dart' as http;

class SingUpService {
  sigUp(String email, String password) async {
    Uri url = Uri.https(
        "ummaisprajesusapp-default-rtdb.firebaseio.com", "/users.json");
    http.Response response = await http.post(url,
        body: json.encode(
          {
            "email": "",
            "password": "",
            "returnSecureToken": true,
          },
        ));
  }
}
