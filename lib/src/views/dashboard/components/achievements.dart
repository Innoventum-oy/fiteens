import 'package:flutter/material.dart';
import '../../achievements.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'badgedisplays.dart';
Widget achievements(user,badges,context)
{
return Row(children: <Widget>[
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
                      padding: const EdgeInsets.all(13.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.achievements,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),

            ),

            //Badges indicator and action link
                      Expanded(
                        flex: 2,
                        child:Padding(
                          padding: const EdgeInsets.fromLTRB(5.0,15.0,5.0,15.0),
                          child:  SingleChildScrollView(
                          scrollDirection:Axis.horizontal,

                            child:
                                Row(
                                  //contains badge status indicator(s)
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: badgeDisplays(badges,user.getValue('activitycount') ?? 0,context)
                                ),


                          ),
                        ),
                      )
          ]);
}