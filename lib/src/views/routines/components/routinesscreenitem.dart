import 'dart:developer';
import 'package:html/parser.dart';
import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/routinescreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/generated/l10n.dart';
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
                        leading: routine.imageUrl != null
                            ? SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  routine.imageUrl!,
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
                            : const Icon(Icons.sports_gymnastics),
                        title: Text((routine.name ?? AppLocalizations.of(context).unnamedRoutine)),
                        subtitle: Text(
                          parse(routine.description ?? '').body!.text,
                          maxLines: 3,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),

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