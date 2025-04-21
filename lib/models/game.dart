import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class Game {
  final User user;
  Game({required this.user});

  Future<void> newGame(List<String> ships, String accountToken) async {
    var url = Uri.https('battleships-app.onrender.com', '/games');
    final String header = 'Bearer $accountToken';
    var response = await http.post(url, headers: {'Content-Type': 'application/json', 'Authorization': header}, body: jsonEncode({'ships': ships}));
    print(response.body);
  }

  Future<void> newAIGame(List<String> ships, String accountToken, String ai) async {
    var url = Uri.https('battleships-app.onrender.com', '/games');
    final String header = 'Bearer $accountToken';
    var response = await http.post(url, headers: {'Content-Type': 'application/json', 'Authorization': header}, body: jsonEncode({'ships': ships, 'ai': ai}));
    print(response.body);
  }

  void cancelGame(int gameID) async {
    var url = Uri.https('battleships-app.onrender.com', '/games$gameID');
    await http.delete(url);
  }

  // returns either a list of active games or completed games based on the value of the 'active' parameter
  Future<List> getGames({required bool active}) async { 
    List activeGames = [];
    List completedGames = [];
    var url = Uri.https('battleships-app.onrender.com', '/games');
    final String header = 'Bearer ${user.accToken}';
    var response = await http.get(url, headers: {'Authorization': header});
    var games = jsonDecode(response.body)['games'];

    for (int i = 0; i < games.length; i++) {
      if (games[i]['status'] == 0 || games[i]['status'] == 3) {
        activeGames.add(games[i]);
      } else {
        completedGames.add(games[i]);
      }
    }
    
    if (active) {
      return activeGames;
    } else {
      return completedGames;
    } // 
  }

  Future<Map<String, dynamic>> getGameInfo(int gameID, String accountToken) async {
    var url = Uri.https('battleships-app.onrender.com', '/games/$gameID');
    final String header = 'Bearer ${user.accToken}';
    var response = await http.get(url, headers: {'Content-Type': 'application/json', 'Authorization': header });
    return(jsonDecode(response.body));
  }

  bool isDone(int status){
    return (status == 1 || status == 2);
  }

  Future<Map<String, dynamic>> shoot(final String accountToken, final int gameID, final String shot) async {
    var url = Uri.https('battleships-app.onrender.com', '/games/$gameID');
    final String header = 'Bearer $accountToken';
    var response = await http.put(url, 
    headers: {'Content-Type': 'application/json', 'Authorization': header}, 
    body: jsonEncode({'shot': shot}));
    return(jsonDecode(response.body));
  }

  
}