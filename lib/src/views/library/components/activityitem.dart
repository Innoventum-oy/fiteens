import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/generated/l10n.dart';
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
                        leading: activity.coverpictureurl != null
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  activity.coverpictureurl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.sports_gymnastics);
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              )
                            : const Icon(Icons.sports_gymnastics, size: 40),
                        title: Text(activity.name != null ? activity.name! : " ${AppLocalizations.of(context).unnamedActivity} #${activity.id}"),
                        subtitle: activity.description != null
                            ? Text(
                                parse(activity.description).body!.text,
                                maxLines: 3,
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              )
                            : null,
                        isThreeLine: activity.description != null,
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