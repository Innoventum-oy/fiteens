import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/views/user/card.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:core/core.dart' as core;

/// TODO: update this view
///
class ActivityVisitList extends StatefulWidget {
  final String viewTitle = 'activityvisitlist';
  final core.Activity _activity;
  const ActivityVisitList(this._activity, {super.key});

  @override
  ActivityVisitListState createState() =>
      ActivityVisitListState();
}

class ActivityVisitListState extends State<ActivityVisitList> {

  core.User user = core.User();
  core.WebPage page = core.WebPage();

  final Map<int,core.User> _users = {};
  DateTimeRange myDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days:7)),
      end: DateTime.now().add(const Duration(days:1))
  );

  @override
  void initState() {
    user = Provider.of<core.UserProvider>(context,listen:false).user;
    core.ActivityVisitProvider visitListProvider = Provider.of<core.ActivityVisitProvider>(context,listen:false);
    visitListProvider.user = user;
    visitListProvider.loadVisitsForActivity(widget._activity,);
    _loadWebPage(user);

    super.initState();
  }

  /* load related page */
  _loadWebPage(user)async {
    await Provider.of<core.WebPageProvider>(context, listen: false).loadItem({
      'language': Localizations.localeOf(context).toString(),
      'commonname': widget.viewTitle,
      'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
      if (user.token != null) 'api_key': user.token,
    });
    setState(() {
      //  this.page = Provider.of<WebPageProvider>(context, listen: false).page;
    });
  }
  @override
  Widget build(BuildContext context) {

    core.ActivityVisitProvider visitListProvider = Provider.of<core.ActivityVisitProvider>(context);
    List<core.ActivityVisit> visits = visitListProvider.list ?? [];


    return Scaffold(
      appBar: AppBar(
        title: Text("${widget._activity.name??'Activity'}: ${AppLocalizations.of(context)!.eventLog}"),
        elevation: 0.1,

      ),
      body:Column(
        children:[


          //results
    visits.isNotEmpty ? Expanded(child:ListView.builder(
        shrinkWrap: true,
          itemCount: visits.length,
          itemBuilder: (BuildContext context, int index) {
            core.ActivityVisit visit = visits[index];

            if(_users.isNotEmpty && _users.containsKey(visit.userid) )
            {
              core.User user = _users[visit.userid]!;
              return userListTile(visit,user);
           }
            Future<core.User> userdata = visit.userprovider!.loadUser(visit.userid ?? 0, user);

            return FutureBuilder(
                initialData: core.User(),
                future: userdata,
                builder: (context, AsyncSnapshot snapshot){


                  if(snapshot.data==null){
                    var titleDateFormat = DateFormat('dd.MM HH:mm');
                    return ListTile(
                      leading: const Icon(Icons.error),
                      title: Text('${titleDateFormat.format(visit.startdate?? DateTime.now())}: ${AppLocalizations.of(context)!.userNotFound}'),
                    );
                  }
                  if(snapshot.data.id!=null ){
                   core.User user = snapshot.data;
                    _users.putIfAbsent(user.id!,()=>user);
                   // if(!users.containsKey(user.id)) users[user.id!] = user;

                    return userListTile(visit,user);
                  }
                  else {
                    var titleDateFormat = DateFormat('dd.MM HH:mm');
                    return ListTile(
                      leading: const CircularProgressIndicator(),
                      title: Text('${titleDateFormat.format(visit.startdate?? DateTime.now())}: ${AppLocalizations.of(context)!.loading}'),
                    );
                  }
                }
            );
          }
      ),) :  ListTile(
          leading: const Icon(Icons.info_outline),title:Text('${AppLocalizations.of(context)!.noVisitsFound} ${DateFormat('d.M.y').format(myDateRange.start)}${myDateRange.duration.inDays > 0 ? ' - ${DateFormat('d.M.y').format(myDateRange.end)}' :''}')
      )
     ] ),

    );

  }

  Widget userListTile(core.ActivityVisit visit, core.User user)
  {
   // var titleDateFormat = new DateFormat('dd.MM HH:mm');
   return ListTile(
      leading: InkWell(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: user.data!['userimageurl'] != null && user.data!['userimageurl']!.isNotEmpty
                ? CachedNetworkImageProvider(user.data!['userimageurl']!)
                : null,
            child: getInitials(user),
          ),
          onTap: () {
            if(user.id != null) {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCard(user:user)),
            );
            }

          }),
      /*
      title: Text(titleDateFormat.format(visit.startdate?? DateTime.now()).toString()+': '+user.fullname),
      subtitle: user.userbenefits.isNotEmpty ? Container(
        height: 30,
        //padding: EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
            ),
            itemCount: user.userbenefits.length,
            itemBuilder: (BuildContext context, int index) {
              return _userBenefitListItem(user.userbenefits[index]);
            }),
      )
          : Text(AppLocalizations.of(context)!.noActiveBenefits), */
    );
  }
}