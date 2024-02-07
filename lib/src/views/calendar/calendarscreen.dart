import 'dart:collection';
import 'dart:developer';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../util/constants.dart' as constants;
import 'components/calendaritem.dart';

/// Creates a Calendar displaying user routines + generically available activities
class CalendarScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;

  const CalendarScreen({this.navIndex=1,this.refresh=false,super.key});

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin  {
  bool screenDataLoaded = false;
  Map<int,Activity> data = {};
  Map<DateTime, List<Map<String,dynamic>>> _events = {};
  ValueNotifier<List<Map<String,dynamic>>> _selectedEvents = ValueNotifier([]);

  Map<DateTime, List<Map<String,dynamic>>> eventsHashMap = <DateTime, List<Map<String,dynamic>>>{};
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // CALENDAR SETTINGS
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? kFirstDay;
  DateTime? kLastDay;


  Map<String, dynamic>? map;
  int limit = 1000;

  String? errorMessage;

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('INITING Calendar screen');
    }
    /// Load events based on activityvisits

    load();

    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay?? DateTime.now()));
  }
  void load() async{

    DateTime now = DateTime.now();
    ActivityVisitProvider visitProvider = Provider.of<ActivityVisitProvider>(context,listen: false);
    Map<String,dynamic> params = {
      'user.id' : Provider.of<UserProvider>(context, listen: false).user.id.toString(),
      //'activity.id' :'gt:0'
    };
    log('called calendarscreen load, provider status: ${visitProvider.loadingStatus}');
    bool reload = false;
    if(!screenDataLoaded || widget.refresh) reload = true;
    await visitProvider.getItems(params,reload:reload);
    List<ActivityVisit> items = visitProvider.data ?? [];
    log('Item count. ${items.length}');
    for (var item in  items) {
      log(item.toString());
      if(item.startdate!=null && item.activity?.id!=null) {
        var date = DateTime.utc(item.startdate!.year, item.startdate!.month, item.startdate!.day);
        if (_events[date] == null) {
          _events[date] = [];
        }
          if(item.activity!=null && !data.containsKey(item.activity?.id)){
            //Load activity info
            log('Retrieving details for activity ${item.activity?.id}');

            Activity activity = Activity.fromJson(await Provider.of<ActivityProvider>(context,listen:false).getDetails(item.activity?.id??0,reload: true));
            data.putIfAbsent(item.activity?.id??0, () => activity);

          }
          else if(item.activity?.id==null) log('activity not set for activityvisit');
          else log('${item.activityid}. already in events');
          Map<String,dynamic> value = {'activity': data[item.activity?.id]!, 'activityVisit' : item};
          log('adding event $item to date $date');
        _events[date]!.add(value);

      }
      else log("$item startdate is null");
    }

    //print('Adding all '+ _events.length.toString() +' events to eventsHashMap');
    eventsHashMap =
    LinkedHashMap<DateTime, List<Map<String,dynamic>>>(equals: isSameDay,
      hashCode: getHashCode,
    )
      ..addAll(_events);
    //print("events in hashmap " + eventsHashMap.length.toString());
    _onDaySelected(_focusedDay, _focusedDay);
    _getEventsForDay(_selectedDay ?? now);
    setState(() {
      screenDataLoaded = true;
    });
  }
  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Map<String,dynamic>> _getEventsForDay(DateTime day) {
    if(kDebugMode) {
      int eventCount = eventsHashMap[day] == null ? 0 : eventsHashMap[day]!
          .length;
      log('events for $day: $eventCount');
    }
      return eventsHashMap[day] ?? [];

  }

  @override
  Widget build(BuildContext context) {

    Widget calendarView = defaultContent(Center(child:
      CircularProgressIndicator(),

    ));
    if (screenDataLoaded) {

      calendarView =calendarContent();
    }

    return ScreenScaffold(
        title: AppLocalizations.of(context)!.calendar,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh ,
        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }
          Provider.of<ActivityVisitProvider>(context).loadingStatus = DataLoadingStatus.loading;
          constants.Router.navigate(context,'calendar',widget.navIndex,refresh: true);
        },
        child: calendarView);
  }

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {

  if (!isSameDay(_selectedDay, selectedDay)) {
    setState(() {
      //print('is not same day: '+selectedDay.toString());
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      //_rangeStart = null; // Important to clean those
      //_rangeEnd = null;
      //  _rangeSelectionMode = RangeSelectionMode.toggledOff;
      _selectedEvents.value = _getEventsForDay(selectedDay);
      //print(_selectedEvents);
    });


  }
  // else print('was same day');
}
  Widget calendarContent() {
    log('Current locale: ${Intl.getCurrentLocale()}');

    final kNow = DateTime.now();
    kFirstDay = DateTime(kNow.year, kNow.month - 1, kNow.day);
    kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
    return Column(
      children: [
        TableCalendar<Map<String,dynamic>>(
          locale: Localizations.localeOf(context).toString(),//Intl.getCurrentLocale(),
          availableCalendarFormats: {
            CalendarFormat.month: AppLocalizations.of(context)!.month,
            CalendarFormat.week: AppLocalizations.of(context)!.week,
            CalendarFormat.twoWeeks: AppLocalizations.of(context)!.twoWeeks,
          },
          firstDay: kFirstDay ?? kNow,
          lastDay: kLastDay ?? kNow,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(markerDecoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle,)),
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: _onDaySelected,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
          eventLoader: _getEventsForDay,
        ), const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Map<String,dynamic>>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              print(value);
              return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {

                    return CalendarItem(value[index]);
                  });
            },
          ),
        ),
      ],
    );

  }
Widget defaultContent(contentChild){
  return Padding(
      padding:EdgeInsets.all(30),
      child:Center(
          child:contentChild)

  );

}
}