import 'package:flutter/cupertino.dart';
import 'usernamelabel.dart';
import 'useravatar.dart';

Widget userTile(user,context){
  String username = user.fullname;
  return  Container(
    decoration: new BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      image: new DecorationImage(
        image: new AssetImage('images/dashboard.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding:EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Expanded(flex: 3, child: userNameLabel(context, username)),
        //User profile image (avatar)
        Expanded(
          flex: 1,
          child:Center(child:userAvatar(user,context)),
        ),
      ])
    ),
  );
}