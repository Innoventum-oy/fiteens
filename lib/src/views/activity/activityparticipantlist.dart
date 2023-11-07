import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/views/user/card.dart';
import 'package:core/core.dart' as core;

import '../../util/utils.dart';

/// TODO: update this view

class ActivityParticipantList extends StatefulWidget {
  final core.ActivityDate _activityDate;
  final core.Activity _activity;

  ActivityParticipantList(this._activityDate,this._activity);

  @override
  _ActivityParticipantListState createState() =>
      _ActivityParticipantListState();
}

class _ActivityParticipantListState extends State<ActivityParticipantList> {
  final core.ApiClient _apiClient = core.ApiClient();
  bool userListLoaded = false;
  bool visitListLoaded = false;
  List<core.User> users = [];
  Map<dynamic,String> activityVisitData ={};
  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _loadActivityUsers(activityDate) async {
    try {
      var activityUserData =
      await Provider.of<core.ActivityProvider>(context).getActivityUsers(widget._activity.id!);


      setState(() {
        userListLoaded = true;
        if (activityUserData.isNotEmpty) {
          users.addAll(activityUserData);
          print(activityUserData.length.toString() + ' users loaded');
          _loadActivityVisits(widget._activity.id!,widget._activityDate);
        } else {
          print('no users found for activity');
        }
      });
    } catch (e, stack) {
      print('loadActivityUsers returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      e.toString();
    }
  }
  void _loadActivityVisits(activity,activitydate) async {
    try {
      this.activityVisitData =
      await Provider.of<core.ActivityProvider>(context).getActivityDateVisits(widget._activity.id!,activitydate);

      setState(() {
        visitListLoaded = true;
        if (this.activityVisitData.isNotEmpty) {
          print(this.activityVisitData.length.toString() + ' visits loaded');
        } else {
          print('no visit information found for activity');
        }
      });
    } catch (e, stack) {
      print('loadActivityVisits returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      e.toString();
    }
  }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _loadActivityUsers(widget._activityDate);

    });

   // Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  @override
  Widget build(BuildContext context) {
    var titleDateFormat = new DateFormat('dd.MM hh:mm');
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(AppLocalizations.of(context)!.participants+ ' '+(widget._activityDate.startdate !=null ? titleDateFormat.format(widget._activityDate.startdate ?? DateTime.now()).toString() : ''))
        ),
        body: userListLoaded ? userList() : Center(child:CircularProgressIndicator(),
        ),
    );

  }
  Widget userList()
  {
    final loggedInUser = Provider.of<core.UserProvider>(context, listen: false).user;
    if(users.isEmpty)
      return Align(
          alignment: Alignment.center,
          child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
              Icon(Icons.info),
              Text(AppLocalizations.of(context)!.noUsersFound,textAlign:TextAlign.center,)
          ]),
      );
    return ListView.builder(
        itemBuilder: (context,index){
          core.User user = users[index];
        //  print(user.data!['huoltajan_puhelinnumero']);
      return SwitchListTile(
      //  isThreeLine: true,
        value: activityVisitData[user.id.toString()]=='visited' ?true:false,
        title: Text(user.firstname!+' '+user.lastname!),
       // subtitle:
        secondary: InkWell(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: user.data!['userimageurl'] != null && user.data!['userimageurl']!.isNotEmpty
                  ? CachedNetworkImageProvider(user.data!['userimageurl']!)
                  : null,
              child: getInitials(user),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCard(user:user)),
              );

            }),//Icon(Icons.supervised_user_circle_sharp),
        onChanged: (bool value) async {

            notify(value ? AppLocalizations.of(context)!.activityRecorded : AppLocalizations.of(context)!.visitRemoved);
            Map<String,dynamic> result = await _apiClient.updateActivityRegistration(activityId:widget._activity.id!,visitStatus:value ? 'visited':'cancelled',visitor: user,user:loggedInUser,visitDate:widget._activityDate) ;
            setState(() {
            if(result['visitstatus']!=null) {
              print('updatevisit returned visitstatus '+result['visitstatus'].toString()+' for user '+result['userid']);
              activityVisitData[result['userid']] = result['visitstatus'];
              print(activityVisitData);
            }

          });

        }
      );
    },
    itemCount:users.length
    );
  }
}

