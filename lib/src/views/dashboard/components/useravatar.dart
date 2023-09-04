import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';

import '../../user/card.dart';

Widget userAvatar(core.User user,context) {
  return  GestureDetector(
    onTap:  () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyCard()),
      );
    },
    child:
  CircleAvatar(
    minRadius: 25,
      maxRadius: 35,
      backgroundImage: user.image != null && user.image!.isNotEmpty
          ? Image.network(
        width:30,
        user.image!,
        fit: BoxFit.cover
      ).image
          : Image.asset('images/profile.png').image,
     // backgroundColor: Colors.white,
    )
  );
}