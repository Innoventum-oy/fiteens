import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import '../../badge.dart';

Widget badgeIconDisplay(core.Badge badge, BuildContext context) {
  String badgeUrl = badge.badgeimageurl ?? '';
  bool hasImage = badge.badgeimageurl != null ? true : false;
  //   print('showing badge image: '+badgeUrl);
  return Container(

    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BadgeView(badge)),
        );
      },
      child: Column(

        //    mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child:  hasImage
                  ? FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                height: 70,
                width:70,
                placeholder: 'images/logo.png',
                image: badgeUrl,
              )
                  : Image(image: AssetImage('images/logo.png')),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              badge.name ?? '-',
              maxLines: 2,
              style: TextStyle(fontSize: 14),


            ),
          ]),
    ),
  );
}