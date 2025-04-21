import 'battleship_main.dart';
import 'comepleted_games.dart';
import 'game_screen.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class NavDrawer extends StatelessWidget {
  final User user;
  const NavDrawer({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final String _username = user.user;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: 
            Column(
              children: [
                Text(style: TextStyle(fontSize: 25), textAlign: TextAlign.center, "Battleships"),
                Padding(padding: EdgeInsets.all(20)),
                Text(textAlign: TextAlign.center, "Logged in as $_username")
              ],
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.add),
                Padding(padding: EdgeInsets.all(10)),
                Text("New game")
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user)));
            } 
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.adb),
                Padding(padding: EdgeInsets.all(10)),
                Text("New game (AI)")
              ],
            ),
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Which AI do you want to play?'),
                    content: Text(user.errMsg),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'oneship')));
                        },
                        child: Text('One ship')),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'random')));
                        },
                        child: Text('Random')),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'perfect')));
                        },
                        child: Text('Perfect')),
                    ],
                  );
                });
            }  
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.menu_book),
                Padding(padding: EdgeInsets.all(10)),
                Text("Show completed games")
              ],
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompletedGames(user: user)))
            
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.logout),
                Padding(padding: EdgeInsets.all(10)),
                Text("Log out")
              ],
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()))
          ),
        ],
      ),
    );
  }
}

class CompletedGamesNavDrawer extends StatelessWidget {
  final User user;
  const CompletedGamesNavDrawer({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final String _username = user.user;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: 
            Column(
              children: [
                Text(style: TextStyle(fontSize: 25), textAlign: TextAlign.center, "Battleships"),
                Padding(padding: EdgeInsets.all(20)),
                Text(textAlign: TextAlign.center, "Logged in as $_username")
              ],
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.add),
                Padding(padding: EdgeInsets.all(10)),
                Text("New game")
              ],
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user)))
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.adb),
                Padding(padding: EdgeInsets.all(10)),
                Text("New game (AI)")
              ],
            ),
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Which AI do you want to play?'),
                    content: Text(user.errMsg),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'oneship')));
                        },
                        child: Text('One ship')),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'random')));
                        },
                        child: Text('Random')),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewGameScreen(user: user, ai: 'perfect')));
                        },
                        child: Text('Perfect')),
                    ],
                  );
                });
            }
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.menu_book),
                Padding(padding: EdgeInsets.all(10)),
                Text("Show active games")
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BattleshipMain(user: user)));
            } 
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.logout),
                Padding(padding: EdgeInsets.all(10)),
                Text("Log out")
              ],
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()))
          ),
        ],
      ),
    );
  }
}