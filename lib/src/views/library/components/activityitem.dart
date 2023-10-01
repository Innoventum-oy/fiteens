import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ActivityItem extends StatelessWidget{
  
  final Activity activity;
  
  ActivityItem(this.activity);
  
  @override
  Widget build(BuildContext context){
    if(kDebugMode){
      log('Displaying ActivityItem ${activity.toString()}');
    }
    return Center(
        child:
        Card(
            child: InkWell(
                onTap: () => {},
                child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: activity.coverpictureurl!=null ? Image.network(activity.coverpictureurl!,width:50): Icon(Icons.sports_gymnastics),
                        title: Text((activity.name != null ? activity.name: AppLocalizations.of(context)!.unnamedActivity)!),
                        subtitle: Text((activity.description??''),
                            overflow: TextOverflow.ellipsis,
                            maxLines:10),
                        isThreeLine: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                       // children: buttons,
                      ),
                    ]
                )
            )
        )
    );
  }
  
}