import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:core/core.dart' as core;

class ActivityListItem extends StatefulWidget {

  final core.ApiClient _apiClient = core.ApiClient();
  final core.Activity activityItem;
 

  ActivityListItem(this.activityItem);
  @override
  State<StatefulWidget> createState() => _ActivityListItemState();
}
class _ActivityListItemState extends State<ActivityListItem>{
  Timer? _timer;
  
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
  @override
  Widget build(BuildContext context){
    core.User user = Provider.of<core.UserProvider>(context).user;
    String dateinfo = widget.activityItem.nexteventdate==null ? '':(calculateDifference(widget.activityItem.nexteventdate!)!=0 ? DateFormat('kk:mm dd.MM.yyyy').format(widget.activityItem.nexteventdate!) : 'Today '+DateFormat('kk:mm ').format(widget.activityItem.nexteventdate!));
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