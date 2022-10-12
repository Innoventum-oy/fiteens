import 'package:flutter/material.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
//import 'package:luen/src/views/dashboard.dart';


class Welcome extends StatelessWidget {
  final User user;

  Welcome({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Provider.of<UserProvider>(context).setUser(user);
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
                             Image.asset('images/riveillalogo.png'),
                              ),
                             Text("Luen - Lukudiplomi"),
                             ElevatedButton(
                                child: Text('Jatka'),
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
