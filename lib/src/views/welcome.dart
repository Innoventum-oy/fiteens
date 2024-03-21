import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart' as core;

class Welcome extends StatelessWidget {
  final core.User user;

  const Welcome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    Provider.of<core.UserProvider>(context).setUser(user);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splashbg.png"),
                fit: BoxFit.cover
            ),

        ),
          constraints: const BoxConstraints.expand(),
          child:
                Expanded(
                  child:
                   Center(
                   child:
                    Row(
                      children:<Widget>[
                        Column(
                          children: <Widget>[
                           Center(
                              child:
                             Image.asset('images/fiteens-logotext-white.png'),
                              ),
                             const Text("Fiteens"),
                             ElevatedButton(
                                child: const Text('Continue'),
                               onPressed: () {
                              // Navigate to the second screen using a named route.
                               Navigator.pushNamed(context, '/dashboard');
                               }
                              ),
                           ]
                          )
                        ]   //children
                       )//row
                )//center
                )//expanded

              )
        ]
      )
        );
  }
}
