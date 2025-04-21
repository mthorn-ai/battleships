import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String password;
  String accessToken = '';
  String errorMsg = '';
  bool successfullLogin = false;

  User({required this.username, required this.password});

  String get accToken {
    return accessToken;
  }

  bool get loggedInStatus {
    return successfullLogin;
  }

  String get user {
    return username;
  }

  String get pass {
    return password;
  }

  String get errMsg {
    return errorMsg;
  }

  Future<void> login({required String username, required String password}) async {
    var url = Uri.https('battleships-app.onrender.com', '/login');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'username': username, 'password': password}));
    final bool loggedIn = response.statusCode == 200;

    if (loggedIn) {
      accessToken = jsonDecode(response.body)['access_token'];
      successfullLogin = true;
    } else {
      errorMsg = jsonDecode(response.body)['error'];
      successfullLogin = false;
    }
  }

  Future<void> register({required String username, required String password}) async {
    var url = Uri.https('battleships-app.onrender.com', '/register');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode({'username': username, 'password': password}));
    bool successfullRegister = response.statusCode == 200;
    if (successfullRegister) {
      accessToken = jsonDecode(response.body)['access_token'];
      successfullLogin = true;
    } else {
      errorMsg = jsonDecode(response.body)['error'];
      successfullLogin = false;
    }
  }
  
}