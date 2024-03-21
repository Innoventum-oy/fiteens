import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../util/navigator.dart';
import '../../activity/activity.dart';


Widget dayItem(Activity activity,BuildContext context){
  return InkWell(
      onTap: () => {

    goToWidget(context,ActivityScreen(activity))
  },
  child: Card(
    child: ListTile(
      //leading: CircleAvatar(
        //backgroundImage: activity.coverpicture!=null ? Image.network(activity.coverpictureurl??''  ).image :
        //Image.asset('images/logo.png').image,),
      title: Text(activity.name??'',
          style: const TextStyle(fontSize: 12)
      ),
        //subtitle: Text(activity.description??''),
    )
  ),
  );
}