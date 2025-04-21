import 'package:battleships/views/game_screen.dart';
import 'package:flutter/material.dart';
import 'nav_drawer.dart';
import '../models/user.dart';
import '../models/game.dart';

class BattleshipMain extends StatefulWidget {
  final User user;
  const BattleshipMain({required this.user, super.key});

  @override
  State<BattleshipMain> createState() => _BattleshipMainState(user: user);
}

class _BattleshipMainState extends State<BattleshipMain> {
  final User user;
  _BattleshipMainState({required this.user});

  @override
  Widget build(BuildContext context) {
    final Game game = Game(user: user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Games'),
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
      drawer: NavDrawer(user: user),
      body: FutureBuilder(
        future: game.getGames(active: true), 
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
                    games[i]['status']==3 
                    ? Text('${games[i]['player1']} vs ${games[i]['player2']}') 
                    : Text("Waiting for opponent"),
                    Spacer(),
                    if (games[i]['turn'] == 0) ...[
                      const Text("matchmaking")
                    ] else if (games[i]['turn'] == games[i]['position']) ...[
                      const Text('Your turn')
                    ] else ...[
                      Text('opponents turn')
                    ]
                  ],
                ),
                onTap: () async {
                  final gameInfo = await game.getGameInfo(games[i]['id'], user.accToken);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(user: user, gameInfo: gameInfo, completed: false, yourTurn: games[i]['turn'] == games[i]['position'])));
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
                  backgroundColor: Colors.red[300],
                  ),
              )
            );
          }
        }
      )
    );
  }
}