import 'dart:async';
import 'dart:developer';

import 'package:core/core.dart' as core;
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
  final core.Routine routine;
  const RoutineScreen(this.routine, {super.key});

  @override
  State<StatefulWidget> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  core.Routine? routine;
  core.ImageObject? routineImage;
  List<core.RoutineItem> items = [];
  final core.ApiClient _apiClient = core.ApiClient();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    log('routinescreen load called for routine ${widget.routine.id}');
    routine = core.Routine.fromJson(
        await Provider.of<core.RoutineProvider>(context, listen: false)
            .getDetails(widget.routine.id ?? 0, reload: true));

    log("Routine $routine has ${routine?.items?.length} items, image: ${routine?.imageUrl}");
    routine?.items?.forEach((element) async {
      log('loading details for routineitem ${element.id}');
      core.RoutineItem r = core.RoutineItem.fromJson(
          await Provider.of<core.RoutineItemProvider>(context, listen: false)
              .getDetails(element.id ?? 0, reload: true));
      await r.loadActivity();

      setState(() {
        items.add(r);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    routine ??= widget.routine;

    Widget routineView;
    //RoutineItemProvider routineItemProvider = Provider.of<RoutineItemProvider>(context);
    if (kDebugMode) {
      log('displaying routine $routine, loaded? ${routine?.loaded}');
    }

    final TextTheme textTheme = Theme.of(context).textTheme;

    List<Widget> widgets = [
      Text(
        routine?.name ?? AppLocalizations.of(context)!.unnamedRoutine,
        style: textTheme.bodyMedium
            ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Container(
        height: 8.0,
      )
    ];

    if (routine?.description != null) {
      widgets.add(Html(
        data: (routine?.description),
      ));
    }

    /// Add to calendar - button
    DateTime currentDate = DateUtils.dateOnly(DateTime.now());
    widgets.add(ElevatedButton(
      child: _apiClient.isProcessing
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                value: null,
                semanticsLabel: AppLocalizations.of(context)!.loading,
              ))
          : Text(AppLocalizations.of(context)!.btnAddToCalendar),
      onPressed: () async {
        DateTimeRange? routineRange = await showDateRangePicker(
            context: context,
            firstDate: currentDate,
            lastDate: currentDate.add(const Duration(days: 365)));
        Map<String, dynamic> params = {
          'action': 'addroutine',
          'objectid': routine?.id.toString(),
          'startdate': routineRange?.start.toString(),
          'enddate': routineRange?.end.toString()
        };

        var result = await _apiClient.dispatcherRequest('activity', params);

        if (result['status'] == 'success') {
          log('displaying success message');
          Provider.of<RoutineProvider>(context,listen: false).getItems({}, reload: true);
          showMessage(
              context,
              AppLocalizations.of(context)!.calendarUpdated,
              Row(
                children: [
                  const Icon(Icons.check),
                  Text(AppLocalizations.of(context)!.routineAddedToCalendar)
                ],
              ));
        } else {
          log('displaying error message');
          var message = Column(children: [
            const Icon(Icons.error_outline),
            if (result['message'] != null) Text(result['message']),
            if (result['error'] != null) Text(result['error'])
          ]);
          showMessage(context,
              AppLocalizations.of(context)!.addingRoutineFailed, message);
        }
        setState(() {});
      },
    ));
    int weeks = routine?.duration ?? 1;
    int duration = weeks * 7;
    for (int start = 1; start < duration; start += 7) {
      widgets.add(Container(
        height: 8.0,
      ));
      if (weeks > 1) {
        widgets.add(
            Text('${AppLocalizations.of(context)!.week} ${start ~/ 7 + 1}'));
      }
      widgets.add(WeekView(startDay: start, items: items));
    }

    routineView = CustomScrollView(slivers: <Widget>[
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Hero(
            tag: "routine-Tag-${routine?.id}",
            child: routine?.imageUrl != null
                ? FadeInImage.assetNetwork(
                    fit: BoxFit.contain,
                    width: double.infinity,
                    placeholder: cupertinoActivityIndicatorSmall,
                    placeholderScale: 10,
                    image: routine!.imageUrl!,
                  )
                : const Image(image: AssetImage('images/logo.png')),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...widgets,
              ],
            ),
          ),
        ]),
      )
    ]);

    return ScreenScaffold(
        title: widget.routine.name ?? 'Routine', child: routineView);
  }

  void showMessage(BuildContext context, String title, Widget content) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(const Duration(seconds: 5), () {
            Navigator.of(context).pop();
          });

          return AlertDialog(
            //backgroundColor: Colors.red,
            title: Text(title),
            content: SingleChildScrollView(
              child: content,
            ),
          );
        }).then((val) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    });
  }
}
