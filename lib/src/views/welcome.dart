import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart' as core;

class Welcome extends StatelessWidget {
  final core.User user;

  Welcome({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Provider.of<core.UserProvider>(context).setUser(user);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splashbg.png"),
                fit: BoxFit.cover
            ),

        ),
          constraints: BoxConstraints.expand(),
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
                             Text("Fiteens"),
                             ElevatedButton(
                                child: Text('Continue'),
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
