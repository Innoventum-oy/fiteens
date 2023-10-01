/// Single item in the routines screen
/// 
import 'dart:developer';
import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/routinescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fiteens/src/util/navigator.dart';
class RoutinesScreenItem extends StatelessWidget{

  final Routine routine;

  RoutinesScreenItem(this.routine);

  @override
  Widget build(BuildContext context){
    if(kDebugMode){
     // log('Displaying RoutinesScreenItem, routine raw data:');
    //  routine.data?.forEach((key, value) {log("$key:$value");});
    }
    return Center(
        child:
        Card(
            child: InkWell(
                onTap: () => {
                  goToWidget(context,RoutineScreen(routine))
                },
                child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: (routine.image!=null && routine.image!.urlpath!=null) ? Image.network(routine.image!.urlpath! ,width:50): Icon(Icons.sports_gymnastics),
                        title: Text((routine.name != null ? routine.name: AppLocalizations.of(context)!.unnamedRoutine)!),
                        subtitle: Html(data:(routine.description??''),
                          ),
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