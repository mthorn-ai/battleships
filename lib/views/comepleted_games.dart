import 'package:battleships/models/game.dart';
import 'package:flutter/material.dart';
import 'nav_drawer.dart';
import '../models/user.dart';
import 'game_screen.dart';

class CompletedGames extends StatefulWidget {
  final User user;
  const CompletedGames({required this.user, super.key});

  @override
  State<CompletedGames> createState() => _CompletedGamesState(user: user);
}

class _CompletedGamesState extends State<CompletedGames> {
  final User user;
  _CompletedGamesState({required this.user});

  @override
  Widget build(BuildContext context) {
    Game game = Game(user: user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Games'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: Scaffold.of(context).openDrawer, 
              icon: const Icon(Icons.menu)
              );
          }
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              
            }), 
            icon: Icon(Icons.refresh))
        ],
      ),
      drawer: CompletedGamesNavDrawer(user: user),
      body: FutureBuilder(
        future: game.getGames(active: false), 
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var games = snapshot.data;
            return ListView(
              children: List.generate(games!.length, (i) =>
              ListTile(
                title: Row(
                  children: [
                    Text('#${games[i]['id']}'),
                    Padding(padding: EdgeInsets.all(10)),
                    Text('${games[i]['player1']} vs ${games[i]['player2']}'),
                    Spacer(),
                    games[i]['status'] == games[i]['position'] 
                    ? Text(style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),'W')
                    : Text(style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),'L')
                  ],
                ),
                onTap: () async {
                  final gameInfo = await game.getGameInfo(games[i]['id'], user.accToken);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(user: user, gameInfo: gameInfo, completed: true)));
                }
              )
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.deepOrangeAccent,
                  ),
              )
            );
          }
        }
      ),
    );
  }
}