import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/components/weekitems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../widgets/screenscaffold.dart';

/// Single Routine Card
class RoutineScreen extends StatefulWidget {
  final Routine routine;
  const RoutineScreen(this.routine,{super.key});

  @override
  State<StatefulWidget> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      log('displaying routine ${widget.routine}, loaded? ${widget.routine.loaded}');
    }
    return ScreenScaffold(title: widget.routine.name ?? 'Routine', child:  RoutineView(widget.routine));
  }
}

class RoutineView extends StatefulWidget {
  final Routine routine;
  
  const RoutineView(this.routine,{super.key});

  @override
  State<RoutineView> createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    Routine routine = widget.routine;

    List<Widget> widgets = [
      Text(routine.name ?? AppLocalizations.of(context)!.unnamedRoutine,
        style: textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    Container(
    height: 8.0,)
    ];

    if(routine.description!=null)
    widgets.add(Html(
    data:(routine.description),
    ));

    routine.items!.forEach((element) {
      log(element.toString());
    });

    int weeks = routine.duration ?? 1;
    int duration = weeks * 7;
    for(int start = 1; start < duration; start+=7) {
      log('adding week ${start~/7}, duration: ${routine.duration}');
      widgets.add(Container(
        height: 8.0,
      ));
      if(weeks>1) widgets.add(Text('Week ${start~/7+1}'));
      widgets.add(WeekView(startDay: start,items:routine.items));
    }
    /*
    if(routine.files.isNotEmpty) {
      widgets.add(Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5), child: Text('Files')));
      this.files.forEach((file) {
        widgets.add(fileDisplay(file, context));
      });
    }
    else print('no files found related to routine');
    */
    return CustomScrollView(
      slivers: <Widget>[SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Hero(
          tag: "routine-Tag-${routine.id}",
          child: routine.image != null && routine.image!.urlpath !=null
              ? FadeInImage.assetNetwork(
            fit: BoxFit.contain,
            width: double.infinity,
            placeholder: cupertinoActivityIndicatorSmall,
            placeholderScale: 10,
            image: routine.image!.urlpath!,
          )
              : Image(
              image: AssetImage('images/logo.png')),
        ),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...widgets,


              ],
            ),
          ),
        ),

      ]),
    )]
    )
    ;
  }

}
