import 'dart:developer';
import 'package:html/parser.dart';
import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/routinescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart';
import 'package:fiteens/src/util/navigator.dart';
class RoutinesScreenItem extends StatelessWidget{

  final Routine routine;

  const RoutinesScreenItem(this.routine, {super.key});

  @override
  Widget build(BuildContext context){
    if(kDebugMode){
      log('Displaying RoutinesScreenItem, routine raw data:');
      routine.data?.forEach((key, value) {log("$key:$value");});
    }
    return  Center(
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
                        leading: routine.imageUrl!=null ? Image.network(routine.imageUrl! ,width:50): const Icon(Icons.sports_gymnastics),
                        title: Text((routine.name ?? AppLocalizations.of(context)!.unnamedRoutine),

                        ),
                        subtitle: Text(parse(routine.description??'').body!.text,maxLines:3,style: const TextStyle(overflow: TextOverflow.ellipsis),),

                        isThreeLine: true,
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