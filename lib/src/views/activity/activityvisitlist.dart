import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/views/user/card.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:core/core.dart' as core;

/// TODO: update this view
///
class ActivityVisitList extends StatefulWidget {
  final String viewTitle = 'activityvisitlist';
  final core.Activity _activity;
  final core.ActivityVisitProvider visitListProvider = core.ActivityVisitProvider();
  ActivityVisitList(this._activity);

  @override
  _ActivityVisitListState createState() =>
      _ActivityVisitListState();
}

class _ActivityVisitListState extends State<ActivityVisitList> {

  core.User user = new core.User();
  core.WebPage page = new core.WebPage();
  List<core.ActivityVisit> visits=[];
  Map<int,core.User> _users = {};
  DateTimeRange myDateRange = DateTimeRange(
      start: DateTime.now().subtract(Duration(days:7)),
      end: DateTime.now().add(Duration(days:1))
  );

  @override
  void initState() {
    print('initState '+widget.viewTitle);
    this.user = Provider.of<core.UserProvider>(context,listen:false).user;
    widget.visitListProvider.user = this.user;
    _loadWebPage(this.user);


    updateUsers();
    super.initState();
  }
  void updateUsers() async
  {
    print('updateUsers called!'+myDateRange.start.toString());
    List<core.ActivityVisit> visits = ( await widget.visitListProvider.loadVisitsForActivity(widget._activity,loadParams:{'startdate':DateFormat('yyyy-MM-dd').format(myDateRange.start),'enddate':DateFormat('yyyy-MM-dd').format(myDateRange.end)})) as List<core.ActivityVisit>;
    setState((){
      print('setState called!');
      this.visits = visits;

    });
  }

  /* load related page */
  _loadWebPage(user)async {
    print('calling loaditem for webpage');
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


    visits = widget.visitListProvider.list ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget._activity.name??'Activity'}: ${AppLocalizations.of(context)!.eventLog}"),
        elevation: 0.1,
        actions: [

          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                print('Refreshing view');
                updateUsers();


              })
        ],
      ),
      body:Column(
        children:[
          //date range picker
          SafeArea(
            child: DateRangeField(
                firstDate: DateTime(2017),
                enabled: true,
                initialValue: this.myDateRange,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.dateRange,
                  prefixIcon: Icon(Icons.date_range),
                  hintText: 'Please select a start and end date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.end.isAfter(DateTime.now())) {
                    return 'Please enter an earlier end date';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    print('daterange changed');
                    myDateRange = value!;
                    updateUsers();
                  });
                }),
          ),
          //results
    visits.isNotEmpty ? Expanded(child:ListView.builder(
        shrinkWrap: true,
          itemCount: visits.length,
          itemBuilder: (BuildContext context, int index) {
            core.ActivityVisit visit = visits[index];

            if(this._users.isNotEmpty && this._users.containsKey(visit.userid) )
            {
              print('USER already on list!');
              core.User user = this._users[visit.userid]!;
              return userListTile(visit,user);
           }
            print('loading data for user '+visit.userid!.toString() );
            Future<core.User> userdata = visit.userprovider!.loadUser(visit.userid ?? 0, this.user);

            return FutureBuilder(
                initialData: new core.User(),
                future: userdata,
                builder: (context, AsyncSnapshot snapshot){


                  if(snapshot.data==null){
                    var titleDateFormat = new DateFormat('dd.MM HH:mm');
                    return ListTile(
                      leading: Icon(Icons.error),
                      title: Text(titleDateFormat.format(visit.startdate?? DateTime.now())+': '+AppLocalizations.of(context)!.userNotFound),
                    );
                  }
                  if(snapshot.data.id!=null ){
                    print(snapshot.data.toString());
                   core.User user = snapshot.data;
                    this._users.putIfAbsent(user.id!,()=>user);
                   // if(!users.containsKey(user.id)) users[user.id!] = user;

                    return userListTile(visit,user);
                  }
                  else {
                    var titleDateFormat = new DateFormat('dd.MM HH:mm');
                    return ListTile(
                      leading: CircularProgressIndicator(),
                      title: Text(titleDateFormat.format(visit.startdate?? DateTime.now()).toString()+': '+AppLocalizations.of(context)!.loading),
                    );
                  }
                }
            );
          }
      ),) :  ListTile(
          leading: Icon(Icons.info_outline),title:Text(AppLocalizations.of(context)!.noVisitsFound+' '+DateFormat('d.M.y').format(myDateRange.start)+(myDateRange.duration.inDays > 0 ? ' - '+DateFormat('d.M.y').format(myDateRange.end) :''))
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
            if(user.id != null)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCard(user:user)),
            );

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