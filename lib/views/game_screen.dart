import 'package:battleships/views/battleship_main.dart';
import 'package:battleships/models/game.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class GameScreen extends StatefulWidget {
  final Map<String, dynamic> gameInfo;
  final User user;
  final bool completed;
  final bool? yourTurn;
  const GameScreen({required this.gameInfo, required this.user, required this.completed, this.yourTurn});

  @override
  State<GameScreen> createState() => _GameScreenState(gameInfo: gameInfo, user: user, completed: completed, yourTurn: yourTurn);
}

class _GameScreenState extends State<GameScreen> {
  final Map<String, dynamic> gameInfo;
  final User user;
  final bool completed;
  final bool? yourTurn;
  _GameScreenState({required this.gameInfo, required this.user, required this.completed, this.yourTurn});
  

Map<int, String> indexToBoard = 
  {
    0:'A1',
    1:'A2',
    2:'A3',
    3:'A4',
    4:'A5',
    5:'B1',
    6:'B2',
    7:'B3',
    8:'B4',
    9:'B5',
    10:'C1',
    11:'C2',
    12:'C3',
    13:'C4',
    14:'C5',
    15:'D1',
    16:'D2',
    17:'D3',
    18:'D4',
    19:'D5',
    20:'E1',
    21:'E2',
    22:'E3',
    23:'E4',
    24:'E5'
  };
  
  List<bool> isPressed = List.generate(25, (i) => false);
  String shot = '';
  IconData shipIcon = Icons.directions_boat_rounded;   // for users ships
  IconData wrecksIcon = Icons.water;                   // for users sunken ships
  IconData sunkIcon = Icons.bolt_rounded;              // for user hits
  IconData shotsIcon = Icons.close;                    // for user misses
  List<Icons?> icons = List.generate(25, (i) => null);

  @override
  Widget build(BuildContext context) {
    final Game game = Game(user: user);
    final screenWidth = MediaQuery.of(context).size.width;
    final gridWidth = screenWidth * 0.55;
    final cellWidth = (gridWidth - 40) / 5;
    return FutureBuilder(
      future: game.getGameInfo(gameInfo['id'], user.accToken), 
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          var boardState = snapshot.data;
          Future.delayed(Duration.zero, () {
            if (game.isDone(boardState!['status'])){
             showDialog(
              context: context, 
              builder: (BuildContext context) {
                return AlertDialog(
                  title: boardState['status'] == boardState['position'] 
                  ? Text('You won!')
                  : Text('You lose!'),
                  content: Text(user.errMsg),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BattleshipMain(user: user)));
                      },
                      child: Text('Back to home'))
                  ],
                );
              });
            }
          });
          return Scaffold(
            appBar: AppBar(
              title: Text("Take a shot"),
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 90, 0, 85)),
                    SizedBox(height: cellWidth, child: Text("A")),
                    SizedBox(height: cellWidth, child: Text("B")),
                    SizedBox(height: cellWidth, child: Text("C")),
                    SizedBox(height: cellWidth, child: Text("D")),
                    SizedBox(height: cellWidth, child: Text("E")),
                  ]
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        SizedBox(width: cellWidth, child: Text("1")),
                        SizedBox(width: cellWidth, child: Text("2")),
                        SizedBox(width: cellWidth, child: Text("3")),
                        SizedBox(width: cellWidth, child: Text("4")),
                        SizedBox(width: cellWidth, child: Text("5")),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    SizedBox(
                      width: gridWidth,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GridView.count(
                          shrinkWrap: true,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 5,
                          children: List.generate(25, (i) {
                            var currentPoint = indexToBoard[i];
                            var currShips = boardState!['ships']; 
                            var currSunk = boardState['sunk']; 
                            var currWrecks = boardState['wrecks']; 
                            var currShots = boardState['shots']; 
                            return Material(
                              color: shot == indexToBoard[i] ? Colors.amberAccent : Colors.deepOrangeAccent,
                              child: InkWell(
                                onTap: (completed || !yourTurn!)
                                ? null 
                                : () {
                                  if (shot == indexToBoard[i]) {
                                    setState(() {
                                      shot = '';
                                    });
                                  } else {
                                    setState(() {
                                      shot = indexToBoard[i]!;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (currShips.contains(currentPoint) && currSunk.contains(currentPoint)) ...[
                                      Icon(size: 18, shipIcon),
                                      Icon(size: 18, sunkIcon)
                                    ] else if (currShips.contains(currentPoint) && currShots.contains(currentPoint)) ...[
                                      Icon(shipIcon, size: 18),
                                      Icon(shotsIcon, size: 18)
                                    ] else if (currWrecks.contains(currentPoint) && currSunk.contains(currentPoint)) ...[
                                      Icon(wrecksIcon, size: 18),
                                      Icon(sunkIcon, size: 18)
                                    ] else if (currWrecks.contains(currentPoint) && currShots.contains(currentPoint)) ...[
                                      Icon(wrecksIcon, size: 18),
                                      Icon(shotsIcon, size: 18)
                                    ] else if (currShips.contains(currentPoint)) ...[
                                      Icon(shipIcon)
                                    ] else if (currSunk.contains(currentPoint)) ...[
                                      Icon(sunkIcon)
                                    ] else if (currShots.contains(currentPoint)) ...[
                                      Icon(shotsIcon)
                                    ] else if (currWrecks.contains(currentPoint)) ...[
                                      Icon(wrecksIcon)
                                    ] else ...[
                                      Text('')
                                    ]
                                  ],)
                              ),
                            ); 
                          })
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    ElevatedButton(
                      onPressed: (completed || !yourTurn!) 
                      ? null 
                      : () async {
                        Game game = Game(user: user);
                        await game.shoot(user.accToken, boardState!['id'], shot);  
                        setState(() {});                 
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.amberAccent)),
                      child: Text('fire!'))
                  ],
                ),
              ],
            )
          );
        } else {
          return Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.amberAccent,
                ),
            )
          );
        }
      });
    
  }
}

class NewGameScreen extends StatefulWidget {
  final String? ai;
  final User user;
  const NewGameScreen({this.ai, required this.user});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState(ai: ai, user: user);
}

class _NewGameScreenState extends State<NewGameScreen> {
  final String? ai;
  final User user;
  _NewGameScreenState({this.ai, required this.user});

  Map<int, String> indexToBoard = 
  {
    0:'A1',
    1:'A2',
    2:'A3',
    3:'A4',
    4:'A5',
    5:'B1',
    6:'B2',
    7:'B3',
    8:'B4',
    9:'B5',
    10:'C1',
    11:'C2',
    12:'C3',
    13:'C4',
    14:'C5',
    15:'D1',
    16:'D2',
    17:'D3',
    18:'D4',
    19:'D5',
    20:'E1',
    21:'E2',
    22:'E3',
    23:'E4',
    24:'E5'
  };

  List<bool> isPressed = List.generate(25, (index) => false);
  final List<String> ships = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final gridWidth = screenWidth * 0.55;
    final cellWidth = (gridWidth - 40) / 5;
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a shot"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 10,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 90, 0, 85)),
              SizedBox(height: cellWidth, child: Text("A")),
              SizedBox(height: cellWidth, child: Text("B")),
              SizedBox(height: cellWidth, child: Text("C")),
              SizedBox(height: cellWidth, child: Text("D")),
              SizedBox(height: cellWidth, child: Text("E")),
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 10,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                  SizedBox(width: cellWidth, child: Text("1")),
                  SizedBox(width: cellWidth, child: Text("2")),
                  SizedBox(width: cellWidth, child: Text("3")),
                  SizedBox(width: cellWidth, child: Text("4")),
                  SizedBox(width: cellWidth, child: Text("5")),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: gridWidth,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 5,
                    children: List.generate(25, (i) {
                      return Material(
                        color: isPressed[i] == true ? Colors.amberAccent : Colors.deepOrangeAccent,
                        child: InkWell(
                          onTap: () {
                            if (ships.length < 5 || ships.contains(indexToBoard[i])) {
                              if (ships.contains(indexToBoard[i])) {
                                setState(() {
                                  ships.remove(indexToBoard[i]!);
                                  isPressed[i] = !isPressed[i];
                                });
                              } else {
                                setState(() {
                                  ships.add(indexToBoard[i]!);
                                  isPressed[i] = !isPressed[i];
                                });
                              }
                            }
                          },
                        ),
                      ); 
                    })
                  )
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: () async {
                  Game game = Game(user: user);
                  if (ai == null) {
                    await game.newGame(ships, user.accToken);
                  } else {
                    await game.newAIGame(ships, user.accToken, ai!);
                  }
                  
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BattleshipMain(user: user)));
                }, 
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amberAccent)),
                child: Text('submit'))
            ],
          ),
        ],
      )
    );
  }
}