import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../util/navigator.dart';


class CalendarItem extends StatefulWidget {

  final ApiClient _apiClient = ApiClient();
  final Activity activityItem;


  CalendarItem(this.activityItem);

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
      String dateinfo = widget.activityItem.nexteventdate==null ? '':(widget.calculateDifference(widget.activityItem.nexteventdate!)!=0 ? DateFormat('kk:mm dd.MM.yyyy').format(widget.activityItem.nexteventdate!) : 'Today '+DateFormat('kk:mm ').format(widget.activityItem.nexteventdate!));
      List<Widget> buttons=[];
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.readMore),
        onPressed: () {
          /* open activity view */
          goToActivity(context, widget.activityItem);
        },
      ));
      buttons.add(const SizedBox(width: 8));

      if(widget.activityItem.registration
          && ( widget.activityItem.maxvisitors==null || (widget.activityItem.maxvisitors??0) > (widget.activityItem.registeredvisitorcount??0) )
          && ( widget.activityItem.registrationenddate==null || widget.activityItem.registrationenddate!.isAfter(DateTime.now()))
          && user.token!=null) {
        buttons.add(ElevatedButton(
          child: Text(AppLocalizations.of(context)!.signUp),
          onPressed: () {
            print('signing up for activity {$widget.activityItem.name}');
            widget._apiClient.registerForActivity(widget.activityItem.id, user);
          },
        ));
        buttons.add(const SizedBox(width: 8));
      }
      //  print(widget.activityItem.name!+' access:'+ widget.activityItem.accesslevel.toString());

      String subtitle= dateinfo ;
      if(widget.activityItem.registration){
        subtitle+=' ['+(widget.activityItem.registeredvisitorcount!=null ? widget.activityItem.registeredvisitorcount.toString() : '0')+(widget.activityItem.maxvisitors!=null ? '/'+widget.activityItem.maxvisitors.toString() :'') +']';
      }
      if(widget.activityItem.description!=null)subtitle+= '\n'+widget.activityItem.description!;
      return Center(
          child:
          Card(
              child: InkWell(
                  onTap: () => goToActivity(context, widget.activityItem),
                  child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.event),
                          title: Text((widget.activityItem.name != null ? widget.activityItem.name: AppLocalizations.of(context)!.unnamedActivity)!),
                          subtitle: Text(subtitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines:5),
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
        _timer = Timer(Duration(seconds: 5), () {
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


