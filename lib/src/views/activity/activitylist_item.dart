import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/views/qrscanner.dart';
import 'package:core/core.dart' as core;

class ActivityListItem extends StatelessWidget{

  final core.ApiClient _apiClient = core.ApiClient();
  final core.Activity activityItem;
  Timer? _timer;
  ActivityListItem(this.activityItem);

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
  @override
  Widget build(BuildContext context){
    core.User user = Provider.of<core.UserProvider>(context).user;
    String dateinfo = activityItem.nexteventdate==null ? '':(calculateDifference(activityItem.nexteventdate!)!=0 ? DateFormat('kk:mm dd.MM.yyyy').format(activityItem.nexteventdate!) : 'Today '+DateFormat('kk:mm ').format(activityItem.nexteventdate!));
    List<Widget> buttons=[];
    buttons.add(ElevatedButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open activity view */
        goToActivity(context, activityItem);
      },
    ));
    buttons.add(const SizedBox(width: 8));

    if(activityItem.registration
        && ( activityItem.maxvisitors==null || (activityItem.maxvisitors??0) > (activityItem.registeredvisitorcount??0) )
        && ( activityItem.registrationenddate==null || activityItem.registrationenddate!.isAfter(DateTime.now()))
        && user.token!=null) {
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.signUp),
        onPressed: () {
          print('signing up for activity {$activityItem.name}');
          _apiClient.registerForActivity(activityItem.id, user);
        },
      ));
      buttons.add(const SizedBox(width: 8));
    }
  //  print(activityItem.name!+' access:'+ activityItem.accesslevel.toString());
    if(activityItem.accesslevel >= 20) {
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.qrScanner),
        onPressed: () {
          Navigator.push(
              context,
           MaterialPageRoute(builder: (context) => QRScanner(activity: activityItem)));
        },
      ));
      buttons.add(const SizedBox(width: 8));
      }
    String subtitle= dateinfo ;
    if(activityItem.registration){
      subtitle+=' ['+(activityItem.registeredvisitorcount!=null ? activityItem.registeredvisitorcount.toString() : '0')+(activityItem.maxvisitors!=null ? '/'+activityItem.maxvisitors.toString() :'') +']';
    }
    if(activityItem.description!=null)subtitle+= '\n'+activityItem.description!;
    return Center(
      child:
      Card(
        child: InkWell(
          onTap: () => goToActivity(context, activityItem),
         child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.event),
              title: Text((activityItem.name != null ? activityItem.name: AppLocalizations.of(context)!.unnamedActivity)!),
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