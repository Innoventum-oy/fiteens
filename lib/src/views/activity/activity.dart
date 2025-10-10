import 'dart:async';
import 'dart:developer';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart'; // important
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/views/activity/activityvisitlist.dart';
import 'package:html/parser.dart';
import 'package:fiteens/src/views/activity/activityparticipantlist.dart';
import 'package:core/core.dart' as core;

/// Display single activity information
class ActivityScreen extends StatefulWidget {
  final core.Activity _activity;
  final core.ActivityVisit? visit;
  final int? navIndex;
  final bool refresh;
  const ActivityScreen(this._activity,{super.key, this.refresh=false,this.navIndex,this.visit});

  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {

  core.Activity activity = core.Activity();
  List<core.ActivityDate> activityDates = [];
  List<core.ActivityVisit> ? activityVisits;
  Timer? _timer;
  int iteration = 1;
  int buildtime = 1;
  core.ActivityVisit? visit;
  core.ActivityProvider activityProvider = core.ActivityProvider();
  core.ImageProvider imageProvider = core.ImageProvider();
  core.User? user;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    activityProvider.current = null;
   load();
    visit = widget.visit;
  }
  void refreshVisits() async {
    core.ActivityVisitProvider activityVisitProvider = Provider.of<
        core.ActivityVisitProvider>(context, listen: false);
    activityVisits = await activityVisitProvider.loadVisitsForActivity(widget._activity, targetUser: user);
    setState(()  {

      if(kDebugMode){
        log('loaded visits for activity ${widget._activity.id} for user ${user?.id}: ${activityVisits?.length}');
      }
    }
    );
  }
  load() async{
    if(kDebugMode) {
      log('Loading activity details');
    }
    core.ActivityProvider activityProvider = Provider.of<core.ActivityProvider>(context,listen:false);

    user = Provider.of<core.UserProvider>(context,listen:false).user;
    dynamic activityData = await activityProvider.getDetails(widget._activity.id!,reload:!widget._activity.loaded);
    // load visit data if available for user
    refreshVisits();

    if(activityData!=null) {
      log('Loaded details for ${widget._activity.id} : $activityData');
      activity = core.Activity.fromJson(activityData);

      activityProvider.current = activity;

    }
    else{
      if(kDebugMode) {
        log('Failed to load details for ${widget._activity.id}');
      }

    }
    setState(() {
      activity.loaded = true;
    });
  }
  @override
  Widget build(BuildContext context) {

    activityProvider = Provider.of<core.ActivityProvider>(context);
    activity = (activityProvider.current?.id == widget._activity.id ? activityProvider.current : widget._activity)!;
    imageProvider = Provider.of<core.ImageProvider>(context);
    if(kDebugMode){
      log('build - activity loaded status for ${activity.name}: ${activity.loaded}, visit: ${visit?.id} - status : ${visit?.visitstatus}');
    }
    return ScreenScaffold(title: activity.name ?? AppLocalizations.of(context)!.activity,
        navigationIndex: widget.navIndex,
        child: activity.loaded ? CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(activity),
            _buildContentSection(activity),
          ],
        ) : const Center(child: CircularProgressIndicator()))  ;

  }

  List<Widget> buttons(core.Activity activity,{core.ActivityVisit? visit}) {
   // print('building buttons');
    final user = Provider.of<core.UserProvider>(context, listen: false).user;
    List<Widget> buttons = [];

    if(user.token!=null) {
      if(kDebugMode) {
        log(visit.toString());
      }
      if(visit!=null && visit.visitstatus == 'visited'){
        // already done
        buttons.add(ElevatedButton.icon(
          icon: const Icon(Icons.check),
            onPressed: ((){}), label: Text(AppLocalizations.of(context)!.alreadyDone), ));
      }
      else if(visit!=null && visit.visitstatus == 'cancelled'){
        buttons.add(ElevatedButton.icon(
          icon: const Icon(Icons.skip_next),
          onPressed: ((){}), label: const Text('Skipped'), ));
      }
      else {
        // add visit - button
        buttons.add(ElevatedButton(
          child: activityProvider.loadingStatus == core.DataLoadingStatus.loading ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                value: null,
                semanticsLabel: AppLocalizations.of(context)!.loading,
              )) : Text(AppLocalizations.of(context)!.btnMarkAsDone),
          onPressed: () {
            if (visit != null) {
              if (visit.startdate!.isAfter(DateTime.now())) {
                showMessage(
                    context, AppLocalizations.of(context)!.eventInFuture, Text(
                    AppLocalizations.of(context)!.eventCannotBeMarkedBeforeDate(
                        DateFormat('d.M.y').format(visit.startdate!))));
                return;
              }
            }

            recordActivity(activity, user, visit: visit);
            setState(() {

              if (kDebugMode) {
                log('marking activity {$activity.name} as done');
              }
            });
          },
        ));
        // add skip - button if we have activityvisit (date)
        if(visit!=null) {
          buttons.add(ElevatedButton(
          child: activityProvider.loadingStatus == core.DataLoadingStatus.loading ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                value: null,
                semanticsLabel: AppLocalizations.of(context)!.loading,
              )) : Text(AppLocalizations.of(context)!.btnSkip),
          onPressed: () {

              if (visit.startdate!.isAfter(DateTime.now())) {
                showMessage(
                    context, AppLocalizations.of(context)!.eventInFuture, Text(
                    AppLocalizations.of(context)!.eventCannotBeSkippedBeforeDate(
                        DateFormat('d.M.y').format(visit.startdate!))));
                return;
              }

            recordActivity(activity, user, visit: visit, visitstatus: 'cancelled');
            setState(() {
              if (kDebugMode) {
                log('skipping activity {$activity.name}');
              }
            });
          },
        ));
        }
      }


    }


    if (activity.accesslevel >= 20) {
      /*
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.qrScanner),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QRScanner(activity: activity)));
        },
      ));
*/
      buttons.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.eventLog),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityVisitList(activity)));
        },
      ));

    }
   /* for testing
    buttons.add(

        ElevatedButton(onPressed: ()=> showMessage(context,AppLocalizations.of(context)!.activityRecorded ,
           Text(activity.getValue('feedback')!=null ? parse(activity.getValue('feedback')).body!.text : AppLocalizations.of(context)!.activityRecorded)
           ,autoDismiss: false
        )
            , child: Text('Test message'))
    );*/
    return buttons;
  }

  Widget _buildAppBar(core.Activity activity) {

    double screenHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      expandedHeight: screenHeight / 3,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "Activity-Tag-${activity.id}",
              child: activity.coverpictureurl != null
                  ? FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: 'images/logo.png',
                      image: activity.coverpictureurl!,
                    )
                  : const Image(image: AssetImage('images/logo.png')),
            ),
          //  BottomGradient(),
            //_buildMetaSection(activity)
          ],
        ),
      ),
    );
  }
  void recordActivity(core.Activity activity,core.User user,{core.ActivityVisit? visit, String visitstatus = 'visited'}) async
  {
    if(kDebugMode){
      log('Recording visit to activity ${activity.name} (visit: ${visit?.id}, status: $visitstatus)');
    }
    if (activityProvider.loadingStatus != core.DataLoadingStatus.loading) {

      Map<String,dynamic>? result = await activityProvider.registerForActivity(
          activity.id,
          user,
          visitstatus: visitstatus,
          visit:visit
      );
      setState(() {
        switch(result?['status'])
        {
          case 'success':
             List<Widget> messageTexts = [

              Text(activity.getValue('feedback')!=null ? parse(activity.getValue('feedback')).body!.text : AppLocalizations.of(context)!.activityRecorded)
              ];
            if(result?['messages'] != null){
              // add the messages as List of Text widgets to the messagetexts list
              messageTexts.addAll(result?['messages'].map<Widget>((message) => Text(message)).toList());
            }
            Widget messageContents = Column(
                mainAxisSize: MainAxisSize.min,

                children:[...messageTexts]);
            showMessage(context,AppLocalizations.of(context)!.activityRecorded ,messageContents,autoDismiss: false);

            break;
          default:
            var message = Column(
                mainAxisSize: MainAxisSize.min,
                children:[
              const Icon(Icons.error_outline),
              Text(result?['message']),
             if (result?['errormessage']!=null) Text(result?['errormessage'])
            ]);
            showMessage(context, AppLocalizations.of(context)!.error,message);

        }
      if(result?['activityvisit']!=null){
        // set / update activityvisit data
        log("updating visit data from : ${result?['activityvisit']}");
        setState(() {
          // this - reference is required here
          refreshVisits();
          this.visit = core.ActivityVisit.fromJson(result?['activityvisit']);
        });

      }
      });
    }
  }


  Widget activityDateRow(date,activity)
  {
    String dateinfo = date.startdate == null
        ? ''
        : (calculateDifference(date.startdate!) != 0
        ? DateFormat('kk:mm dd.MM.yyyy')
        .format(date.startdate!)
        : 'Today ${DateFormat('kk:mm ').format(date.startdate!)}');
    return Center(
        child: Card(
            child: InkWell(
              //onTap: () => goToActivity(context, activityItem),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.event),
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(dateinfo),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ActivityParticipantList(date,activity)));
                                },
                                child:const Icon(Icons.table_rows_sharp),
                              ),
                            ]
                        ),
                        //     subtitle: Text(activityItem.description==null ? '' : '\n'+activityItem.description!)),
                      ),
                      /* Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: buttons,
                                        ),*/

                    ]))));
  }
  Widget _buildContentSection(core.Activity activity) {

    List<Widget> slivers = [
      Container(
        decoration: const BoxDecoration(color: Color(0xff222128)),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                activity.name != null
                    ? activity.name.toString()
                    : AppLocalizations.of(context)!.unnamedActivity,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),

              const SizedBox(
                height: 8.0,
              ),
              Html(data:activity.description!,
                 ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: buttons(activity,visit: visit),
              )
            ],
          ),
        ),
      ),
    ];

    slivers.add(Padding(
      padding: const EdgeInsets.all(16.0),
      child: !activity.loaded
          ? Center(
        child: ListTile(
          leading: const CircularProgressIndicator(),
          title: Text(AppLocalizations.of(context)!.loading,
              textAlign: TextAlign.center),
        ),
      )
          : activity.data!=null && activity.data?['reasoning']!=null && activity.data?['reasoning'].length >0 ? _parseHtml(activity.data?['reasoning']?? ''):Container(),
    ));

    if(activityVisits!=null && activityVisits!.isNotEmpty) {
      List<Widget> visitTiles = [];
      for (var visit in activityVisits!) {
        visitTiles.add(ListTile(
          leading: const Icon(Icons.calendar_month),
          title: Text(visit.startdate != null
              ? DateFormat('kk:mm dd.MM.yyyy').format(visit.startdate!)
              : 'Date unknown'),
          subtitle: Text(visit.visitstatus ?? ''),
        ));
      }
      slivers.add(Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.yourLogDates,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            const SizedBox(
              height: 8.0,
            ),
            Column(
              children: visitTiles,
            )
          ],
        ),
      ));
    }

    return SliverList(
      delegate: SliverChildListDelegate(

       slivers

      ),
    );
  }
  Widget _parseHtml(content){
    //print('returning parsed content for '+content.toString());
    return Html(
        shrinkWrap: true,
        data: content,
        style: {"*" : Style(color:Colors.white)}
    );
  }
  void showMessage(BuildContext context, String title, Widget content,{bool autoDismiss= true}) {
    showDialog(context: context, builder: (BuildContext builderContext) {
      if(autoDismiss ) {
        _timer = Timer(const Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
      }
      return AlertDialog(
        //backgroundColor: Colors.red,
        title: Text(title),
        scrollable: true,
        content:  content,
        actions: autoDismiss ? null : [
        ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child: const Text('Ok'))
      ],
      );
    }
    ).then((val) {
      if (_timer != null &&_timer!.isActive) {
        _timer!.cancel();
      }
    });
  }
}
