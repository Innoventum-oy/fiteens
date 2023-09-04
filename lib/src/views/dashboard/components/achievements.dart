import 'package:flutter/material.dart';
import '../../../util/utils.dart';
import '../../achievements.dart';
import '../../scorelist.dart';
import '../../webpage/pagelist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'badgedisplays.dart';
Widget achievements(user,badges,context)
{

return Padding(
    //Your status
    padding: EdgeInsets.all(5.0),
    child: Container(

      decoration: new BoxDecoration(
        color: HexColor.fromHex('#FFee962b'), // orange
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: <Widget>[
            // Status indicator
            Expanded(
              flex: 2,
              child:
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AchievementsView()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.achievements,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

            ),


            //Badges indicator and action link

                      Expanded(

                        flex: 3,
                        child:Padding(
                          padding: EdgeInsets.fromLTRB(5.0,15.0,5.0,15.0),
                          child:  SingleChildScrollView(
                          scrollDirection:Axis.horizontal,

                            child:
                                Row(

                                  //contains badge status indicators (3+)
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: badgeDisplays(badges,user.getValue('activitycount') ?? 0,context)
                                ),


                          ),
                        ),
                      )


          ]),
        ),


  );
}