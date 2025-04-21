import '../models/user.dart';
import 'battleship_main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final User user = User(username: usernameController.text, password: passController.text);
                  await user.login(username: user.username, password: user.password);
                  if (user.loggedInStatus && context.mounted) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BattleshipMain(user: user)));
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Login Failed'),
                          content: Text(user.errMsg),
                          actions: [
                            TextButton(
                              onPressed: () {
                                usernameController.text = '';
                                passController.text = '';
                                Navigator.pop(context);
                              },
                              child: Text('Ok'))
                          ],
                        );
                      });
                  }
                },
                child: Text("Login")
                ),
              TextButton(
                onPressed: () async {
                  User user = User(username: usernameController.text, password: passController.text);
                  await user.register(username: user.username, password: user.password);
                  if (user.loggedInStatus && context.mounted){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BattleshipMain(user: user)));
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Register Failed'),
                          content: Text(user.errMsg),
                          actions: [
                            TextButton(
                              onPressed: () {
                                usernameController.text = '';
                                passController.text = '';
                                Navigator.pop(context);
                              },
                              child: Text('Ok'))
                          ],
                        );
                      });
                  }
                },
                child: Text("Register"))
            ],
          )
        ],
      ),
    );
  }
}