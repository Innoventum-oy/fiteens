import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/components/weekitems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:provider/provider.dart';

import '../../widgets/screenscaffold.dart';

/// Single Routine Card
class RoutineScreen extends StatefulWidget {
  final Routine routine;
  const RoutineScreen(this.routine,{super.key});

  @override
  State<StatefulWidget> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  Routine? routine;
  List<RoutineItem> items = [];
  @override void initState() {
    // TODO: implement initState
    super.initState();
    if(!widget.routine.loaded){
      load();
    }

  }
  void load() async{
    log('routinescreen load called for routine ${widget.routine.id}');
    this.routine = Routine.fromJson(await Provider.of<RoutineProvider>(context,listen: false).getDetails(widget.routine.id??0,reload:true));
    log("Routine ${this.routine} has ${routine?.items?.length} items");
    routine?.items?.forEach((element) async {
      log('loading details for routineitem ${element.id}');
      RoutineItem r = RoutineItem.fromJson(await Provider.of<RoutineItemProvider>(context,listen:false).getDetails(element.id??0,reload:true));
      await r.loadActivity();
      items.add(r);
    });

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    if(this.routine == null) this.routine = widget.routine;

    Widget routineView;
    //RoutineItemProvider routineItemProvider = Provider.of<RoutineItemProvider>(context);
    if(kDebugMode){
      log('displaying routine ${this.routine}, loaded? ${this.routine?.loaded}');
    }

      final TextTheme textTheme = Theme.of(context).textTheme;

      List<Widget> widgets = [
        Text(this.routine?.name ?? AppLocalizations.of(context)!.unnamedRoutine,
          style: textTheme.bodyMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 8.0,)
      ];

      if(routine?.description!=null)
        widgets.add(Html(
          data:(routine?.description),
        ));

      int weeks = routine?.duration ?? 1;
      int duration = weeks * 7;
      for(int start = 1; start < duration; start+=7) {
        log('adding week ${start~/7}, duration: ${routine?.duration}');
        widgets.add(Container(
          height: 8.0,
        ));
        if(weeks>1) widgets.add(Text('Week ${start~/7+1}'));
        widgets.add(WeekView(startDay: start,items:items));
      }

    routineView  = CustomScrollView(
          slivers: <Widget>[SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Hero(
                tag: "routine-Tag-${routine?.id}",
                child: routine?.image != null && routine?.image!.urlpath !=null
                    ? FadeInImage.assetNetwork(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  placeholder: cupertinoActivityIndicatorSmall,
                  placeholderScale: 10,
                  image: routine!.image!.urlpath!,
                )
                    : Image(
                    image: AssetImage('images/logo.png')),
              ),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
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
      );

    return ScreenScaffold(title: widget.routine.name ?? 'Routine', child:  routineView);
    }


}



