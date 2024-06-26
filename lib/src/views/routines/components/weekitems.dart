
import 'package:core/core.dart';
import 'package:fiteens/src/views/routines/components/dayitem.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../util/utils.dart';

class WeekView extends StatefulWidget{
  final List<RoutineItem>? items;
  final int startDay;
  const WeekView({super.key, this.items,this.startDay=1});
  @override
  WeekViewState createState() => WeekViewState();
}
class WeekViewState extends State<WeekView> {


  DateTime mostRecentWeekday(DateTime date, int weekday) =>
      DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);


  @override
  Widget build(BuildContext context) {

    List<Widget> days = [];

    DateTime calendarDay = mostRecentWeekday(DateTime.now(),1);
    for(int i = widget.startDay; i<widget.startDay+7; i++){


      List<RoutineItem>? dayItems = widget.items?.where((element) => element.weekday==i).toList();
     // log('Adding ${dayItems?.length} dayItems where weekday is $i');
      days.add(
        weekDayCard(calendarDay,items:dayItems)
      );
      calendarDay = calendarDay.add(const Duration(days:1));
    }
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
    height: 200,
    child:ListView(
      scrollDirection: Axis.horizontal,
      children: days,
    ),
    );
  }

  Widget weekDayCard(calendarDay,{List<RoutineItem>? items})
  {
    List<Widget>dayActivities = [];
    if(items!=null && items.isNotEmpty) {
      for (var element in items) { dayActivities.add(
        dayItem(element.activity??Activity(), context)
      );
      }
    }
      return Card(
          child: SizedBox(
              width: 120,
              height: 100,
              child:InkWell(
                  child:

                  Column(
                    children: [

                      Padding(
                          padding:const EdgeInsets.all(5),
                          child: Column(
                            children:[
                              Text(capitalize(DateFormat('EEEE',Localizations.localeOf(context).toString()).format(calendarDay,)),style: const TextStyle(fontSize: 18),),
                              ...dayActivities,
                              ]
                          )

                      )

                    ],
                  )
              )
          )
      );
    }


}