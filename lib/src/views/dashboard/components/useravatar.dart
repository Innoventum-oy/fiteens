import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/settings/components/avatarPicker.dart';
import 'package:flutter/material.dart';


Widget userAvatar(core.User user,context,{Function? onTap,String? currentAvatar}) {
  ImageProvider image;
  String? avatar = currentAvatar ?? user.data?['avatar'];
  if(avatar!=null)
    image = Image.asset(avatar,
        width:20,
        height:20,
        fit:BoxFit.cover
        ).image;
  else if (user.image != null && user.image!.isNotEmpty)
    image = Image.network(
      width:30,
      user.image!,
      fit: BoxFit.cover
  ).image;
  else image = Image.asset('images/profile.png',
      width:30,
      fit:BoxFit.cover
    ).image;
  return  GestureDetector(
    onTap:  () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AvatarPicker(onTap: onTap,currentImage:currentAvatar)//MyCard()
        ),
      );
    },
      child:CircleAvatar(
    minRadius: 25,
      maxRadius: 35,
      backgroundImage: image,
     // backgroundColor: Colors.white,

  ));
}