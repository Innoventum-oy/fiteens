import 'dart:async';
import 'dart:developer';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../util/navigator.dart';


class CalendarItem extends StatefulWidget {

  //final ApiClient _apiClient = ApiClient();
  final Map<String,dynamic> activityData;


  const CalendarItem(this.activityData, {super.key});

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }




  @override
  State<StatefulWidget> createState() => _CalendarItemState();
}
  class _CalendarItemState extends State<CalendarItem>{
    Timer? _timer;

    @override
    Widget build(BuildContext context){
      User user = Provider.of<UserProvider>(context).user;
      ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);
      Activity activityItem = widget.activityData['activity'];
      ActivityVisit? activityVisit = widget.activityData['activityVisit'];
      if(kDebugMode){
        log("Building calendaritem for activity ${activityItem.name} visit ${activityVisit?.id}");
      }
      String dateinfo = activityItem.nexteventdate==null ? '':(widget.calculateDifference(activityItem.nexteventdate!)!=0 ? DateFormat('kk:mm dd.MM.yyyy').format(activityItem.nexteventdate!) : 'Today ${DateFormat('kk:mm ').format(activityItem.nexteventdate!)}');
      List<Widget> buttons=[];
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.readMore),
        onPressed: () {
          /* open activity view */
          goToActivity(context, activityItem,visit:activityVisit);
        },
      ));
      buttons.add(const SizedBox(width: 8));

      if(activityItem.registration
          && ( activityItem.maxvisitors==null || (activityItem.maxvisitors??0) > (activityItem.registeredvisitorcount??0) )
          && ( activityItem.registrationenddate==null || activityItem.registrationenddate!.isAfter(DateTime.now()))
          && user.token!=null) {
        buttons.add(ElevatedButton(
          child: activityProvider.loadingStatus == DataLoadingStatus.loading ? const CircularProgressIndicator() : Text(AppLocalizations.of(context)!.signUp),
          onPressed: () {
            activityProvider.loadingStatus == DataLoadingStatus.loading ? null : activityProvider.registerForActivity(activityItem.id, user,visit:activityVisit);

          },
        ));
        buttons.add(const SizedBox(width: 8));
      }
      //  print(activityItem.name!+' access:'+ activityItem.accesslevel.toString());

      String subtitle= dateinfo ;
      if(activityItem.registration){
        subtitle+=' [${activityItem.registeredvisitorcount!=null ? activityItem.registeredvisitorcount.toString() : '0'}${activityItem.maxvisitors!=null ? '/${activityItem.maxvisitors}' :''}]';
      }
      if(activityItem.description!=null)subtitle+= '\n${activityItem.description!}';
      return Center(
          child:
          Card(
              child: InkWell(
                  onTap: () => goToActivity(context, activityItem,visit:activityVisit),
                  child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.event),
                          title: Text((activityItem.name ?? AppLocalizations.of(context)!.unnamedActivity)),
                          subtitle: Text(parse(subtitle).body!.text,maxLines: 3,style: const TextStyle(overflow: TextOverflow.ellipsis),
                             ),
                          isThreeLine: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: buttons,
                        ),
                      ]
                  )
              )
          )
      );
    }

    void showMessage(BuildContext context, String title, Widget content) {
      showDialog(context: context, builder: (BuildContext builderContext) {
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
      }
      ).then((val) {
        if (_timer!.isActive) {
          _timer!.cancel();
        }
      });
    }
}


