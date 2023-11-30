import 'package:core/core.dart';
import 'package:flutter/material.dart';

Widget dayItem(Activity activity){
  return Card(
    child: ListTile(
      //leading: CircleAvatar(
        //backgroundImage: activity.coverpicture!=null ? Image.network(activity.coverpictureurl??''  ).image :
        //Image.asset('images/logo.png').image,),
      title: Text(activity.name??''),
        //subtitle: Text(activity.description??''),
    )
  );
}