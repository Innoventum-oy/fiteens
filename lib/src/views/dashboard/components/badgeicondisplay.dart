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
      child: Stack(

        //    mainAxisSize: MainAxisSize.max,
          children: [
            hasImage
                    ? FadeInImage.assetNetwork(

                  fit: BoxFit.contain,


                  placeholder: 'images/badge-placeholder.jpg',
                  image: badgeUrl,
                )
                    : Image(

                    image: AssetImage('images/badge-placeholder.jpg')),


            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom:5,
 child:Text(
              overflow: TextOverflow.ellipsis,
              badge.name ?? '-',
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),

            ),
          ]),
    ),
  );
}