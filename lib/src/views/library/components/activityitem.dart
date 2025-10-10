import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import '../../../util/navigator.dart';
import '../../activity/activity.dart';
class ActivityItem extends StatelessWidget{
  
  final Activity activity;
  final int? navIndex;

  const ActivityItem(this.activity,{super.key, this.navIndex});
  
  @override
  Widget build(BuildContext context){
    if(kDebugMode){
      log('Displaying ActivityItem ${activity.toString()}');
    }
    return Center(
        child:
        Card(
            child: InkWell(
                onTap: () => {
                  goToWidget(context,ActivityScreen(activity,navIndex: navIndex,))
                },
                child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: activity.coverpictureurl!=null ? Image.network(activity.coverpictureurl!,width:50): const Icon(Icons.sports_gymnastics, size: 50),
                        title: Text(activity.name != null ? activity.name! : " ${AppLocalizations.of(context)!.unnamedActivity} #${activity.id}"),
                        subtitle: activity.description!=null ? Text(parse(activity.description).body!.text,maxLines: 3, style: const TextStyle(overflow: TextOverflow.ellipsis),): null,

                        isThreeLine: activity.description!=null,
                      ),
                      const Row(
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